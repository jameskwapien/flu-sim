/** 
 * Test Java program for inputs and outputs.
 */
class TestJavaApp {
    public static void main(String[] args) {
        int firstArg = 0;
        if(args.length > 0){
          try{
            firstArg = Integer.parseInt(args[0]);
          }catch(NumberFormatException e){
            System.err.println("Argument " + args[0] + " must be an integer.");
            System.exit(1);
          }
        }
        int output = 2 * firstArg;
        System.out.println(output);
    }
}
