import java.sql.*;

public class DB {

    private Connection conn = null;
    private Statement s = null;
    private ResultSet rs = null;

    DB() {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost/flusim_development";
            String user = "root";
            String pw = "beltforgetflewdarkness";
            conn = DriverManager.getConnection(url,user,pw);
            System.out.println("Success - " + conn);
        }

        catch(ClassNotFoundException e)
        {
            System.out.println(e.getMessage());
            System.out.println("Class error");
            System.exit(0);
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            System.out.println("SQL error");
            System.exit(0);
        }
    }

    //*****************************************************************************
    public void setRS(String table) throws SQLException{
        s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        String tableSelect = "Select * from " + table;
        rs = s.executeQuery(tableSelect);
    }

    public void toDatabase(int input_id, City city, String groupName, int day ){
        //adds a new species for lists to populate
        try{
            setRS("outputs");
            rs.moveToInsertRow();
            rs.updateInt("input_id", input_id);
            rs.updateString("group_name", groupName);
            rs.updateInt("money_left", city.money_left);
            rs.updateInt("money_spent_ads", city.ads);
            rs.updateInt("money_spent_vaccines", city.money_spent_vaccines); // 13 is the price for the vaccines
            rs.updateInt("vaccs_left", city.cityVaccines);
            rs.updateInt("population", city.population);
            rs.updateInt("sick",city.sick);
            rs.updateInt("immune",city.immune);
            rs.updateInt("pop_age0", city.ages[0]);
            rs.updateInt("sick_age0", city.agesSick[0]);
            rs.updateInt("pop_age1", city.ages[1]);
            rs.updateInt("sick_age1", city.agesSick[1]);
            rs.updateInt("pop_age2", city.ages[2]);
            rs.updateInt("sick_age2", city.agesSick[2]);
            rs.updateInt("cityID",city.cityId);
            rs.updateInt("day", day);
            rs.insertRow();
            rs.moveToCurrentRow();
            rs.close();
            s.close();

        }catch(SQLException e){
            System.out.println(e.getMessage());
            System.exit(0);
        }

    }

    public ResultSet getInputs(String group){
        ResultSet x = null;
        String selection = String.format("Select * from inputs where group_name like '%s'", group);
        try{
            setRS("inputs");
            x = s.executeQuery(selection);
        }
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            System.exit(0);
        }
        return x;
    }

    public boolean checkOutput(int input_id, String group) throws SQLException {
        String tableSelect = String.format("select input_id from outputs where group_name like '%s' and input_id = %d limit 1",
                                            group, input_id);
        s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        return s.executeQuery(tableSelect).next();
    }

    public void dropOutput(int input_id, String group) throws SQLException {
        String tableDelete = String.format("delete from outputs where group_name like '%s' and input_id = %d",
                group, input_id);
        s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
        s.executeUpdate(tableDelete);
    }

}
