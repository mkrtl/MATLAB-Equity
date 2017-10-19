
import com.mathworks.toolbox.javabuilder.*;
import Class1.*;

class plot_equity
{


public static void main(String[] args)
{
	MWNumericArray n = null;
	Object[] result = null;
	Class_one theMagic = null;

	if (args.length == 0) 
	{
		System.out.println("Error: must be positive integer");

	}
	try
	{
		n = new MWNumericArray(Double.valueOf(args[0])),MWClassID.DOUBLE);

		theMagic = new Class_one;

		result = theMagic.plot_states_historic(1,n);
		System.out.println(result[0]);
	}
	catch(Exception e) 
	{
		System.out.println("Exception: " + e.toString());
	}
	finally
	{
		MWArray.disposeArray(n);
		MWArray.disposeArray(result);
		theMagic.dispose();
	}
}
}

