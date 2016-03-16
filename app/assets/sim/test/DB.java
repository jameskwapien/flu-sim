import java.sql.*;

public class DB {

    static Connection conn = null;     
    static Statement s = null;
    static ResultSet rs = null;
    
    public Connection init()
    {
        conn = getConnection();
        System.out.println("YES - " + conn);        
        return conn;
    }
//*****************************************************************************    
    public static Connection getConnection()
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost/flusim_development";
            String user = "root";
            String pw = "beltforgetflewdarkness";
            conn = DriverManager.getConnection(url,user,pw);
            System.out.println("Success");
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
        
        return conn;
    }
//*****************************************************************************    
    public void setRS(String table) throws SQLException
    {
       s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
       String tableSelect = "Select * from "+table;
       rs = s.executeQuery(tableSelect);
    }
    public void toDatabase(City x, String groupName, int day )
    {//adds a new species for lists to populate  
        
        try
        {
            setRS("outputs");
            rs.moveToInsertRow();            
            rs.updateString("group_name", groupName);
            rs.updateInt("money_left", x.cityVaccines);
            rs.updateInt("population", x.population);
            rs.updateInt("sick",x.sick);
            rs.updateInt("immune",x.immune);
            rs.updateInt("pop_age0", x.ages[0]);
            rs.updateInt("sick_age0", x.agesSick[0]);
            rs.updateInt("pop_age1", x.ages[1]);
            rs.updateInt("sick_age1", x.agesSick[1]);
            rs.updateInt("pop_age2", x.ages[2]);
            rs.updateInt("sick_age2", x.agesSick[2]);  
            rs.updateInt("cityID",x.cityId);
            rs.updateInt("day", day);
            rs.insertRow();
            rs.moveToCurrentRow();            
        }
        
        catch(SQLException e)
        {
            System.out.println(e.getMessage());
            System.exit(0);
        }
        
    }
    
    public ResultSet getInputs(String group){
        ResultSet x =null;
        String selection = "Select * from inputs where group_name like '"
                +group+"'";
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
            
}
