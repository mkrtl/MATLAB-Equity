
import com.mathworks.toolbox.javabuilder.*;
import Plot_java_test.*;

class plot_java_test
{


public static void main(String[] args)
{
	MWNumericArray n = null;
	MWNumericArray m = null;
	Object[] result = null;
	Class1 plot = null;

	if (args.length == 0) 
	{
		System.out.println("Error: must be positive integer");

	}
	try
	{
		n = new MWNumericArray(Double.valueOf(args[0]) , MWClassID.DOUBLE);
		m = new MWNumericArray(Double.valueOf(args[1]) , MWClassID.DOUBLE);

		plot = new Class1();

		result = plot.Plot_java_test(1,n,m);
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
		plot.dispose();
	}
}
}

