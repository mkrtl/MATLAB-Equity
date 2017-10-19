/*
 * MATLAB Compiler: 6.4 (R2017a)
 * Date: Wed Oct 04 22:39:11 2017
 * Arguments: 
 * "-B""macro_default""-W""java:Plot_java_example,Plot_java_test""-T""link:lib""-d""C:\\Users\\Max\\Documents\\Werkstudentenstelle\\Klassenansatz_GitHub\\Plot_java_example\\for_testing""class{Plot_java_test:C:\\Users\\Max\\Documents\\Werkstudentenstelle\\Klassenansatz_GitHub\\Plot_java_example.m}"
 */

package Plot_java_example;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;
import java.util.*;

/**
 * The <code>Plot_java_test</code> class provides a Java interface to MATLAB functions. 
 * The interface is compiled from the following files:
 * <pre>
 *  C:\Users\Max\Documents\Werkstudentenstelle\Klassenansatz_GitHub\Plot_java_example.m
 * </pre>
 * The {@link #dispose} method <b>must</b> be called on a <code>Plot_java_test</code> 
 * instance when it is no longer needed to ensure that native resources allocated by this 
 * class are properly freed.
 * @version 0.0
 */
public class Plot_java_test extends MWComponentInstance<Plot_java_test>
{
    /**
     * Tracks all instances of this class to ensure their dispose method is
     * called on shutdown.
     */
    private static final Set<Disposable> sInstances = new HashSet<Disposable>();

    /**
     * Maintains information used in calling the <code>Plot_java_example</code> MATLAB 
     *function.
     */
    private static final MWFunctionSignature sPlot_java_exampleSignature =
        new MWFunctionSignature(/* max outputs = */ 0,
                                /* has varargout = */ false,
                                /* function name = */ "Plot_java_example",
                                /* max inputs = */ 2,
                                /* has varargin = */ false);

    /**
     * Shared initialization implementation - private
     * @throws MWException An error has occurred during the function call.
     */
    private Plot_java_test (final MWMCR mcr) throws MWException
    {
        super(mcr);
        // add this to sInstances
        synchronized(Plot_java_test.class) {
            sInstances.add(this);
        }
    }

    /**
     * Constructs a new instance of the <code>Plot_java_test</code> class.
     * @throws MWException An error has occurred during the function call.
     */
    public Plot_java_test() throws MWException
    {
        this(Plot_java_exampleMCRFactory.newInstance());
    }
    
    private static MWComponentOptions getPathToComponentOptions(String path)
    {
        MWComponentOptions options = new MWComponentOptions(new MWCtfExtractLocation(path),
                                                            new MWCtfDirectorySource(path));
        return options;
    }
    
    /**
     * @deprecated Please use the constructor {@link #Plot_java_test(MWComponentOptions componentOptions)}.
     * The <code>com.mathworks.toolbox.javabuilder.MWComponentOptions</code> class provides an API to set the
     * path to the component.
     * @param pathToComponent Path to component directory.
     * @throws MWException An error has occurred during the function call.
     */
    public Plot_java_test(String pathToComponent) throws MWException
    {
        this(Plot_java_exampleMCRFactory.newInstance(getPathToComponentOptions(pathToComponent)));
    }
    
    /**
     * Constructs a new instance of the <code>Plot_java_test</code> class. Use this 
     * constructor to specify the options required to instantiate this component.  The 
     * options will be specific to the instance of this component being created.
     * @param componentOptions Options specific to the component.
     * @throws MWException An error has occurred during the function call.
     */
    public Plot_java_test(MWComponentOptions componentOptions) throws MWException
    {
        this(Plot_java_exampleMCRFactory.newInstance(componentOptions));
    }
    
    /** Frees native resources associated with this object */
    public void dispose()
    {
        try {
            super.dispose();
        } finally {
            synchronized(Plot_java_test.class) {
                sInstances.remove(this);
            }
        }
    }
  
    /**
     * Invokes the first MATLAB function specified to MCC, with any arguments given on
     * the command line, and prints the result.
     *
     * @param args arguments to the function
     */
    public static void main (String[] args)
    {
        try {
            MWMCR mcr = Plot_java_exampleMCRFactory.newInstance();
            mcr.runMain( sPlot_java_exampleSignature, args);
            mcr.dispose();
        } catch (Throwable t) {
            t.printStackTrace();
        }
    }
    
    /**
     * Calls dispose method for each outstanding instance of this class.
     */
    public static void disposeAllInstances()
    {
        synchronized(Plot_java_test.class) {
            for (Disposable i : sInstances) i.dispose();
            sInstances.clear();
        }
    }

    /**
     * Provides the interface for calling the <code>Plot_java_example</code> MATLAB function 
     * where the first argument, an instance of List, receives the output of the MATLAB function and
     * the second argument, also an instance of List, provides the input to the MATLAB function.
     * <p>
     * Description as provided by the author of the MATLAB function:
     * </p>
     * <pre>
     * % This function plots the standard lorenz curve for a given vector of
     * % states, a selection of those states (indexes) used and indicates, whether
     * % or not the datapoints should be plotted. Is used for
     * % plot_states_historic.
     * </pre>
     * @param lhs List in which to return outputs. Number of outputs (nargout) is
     * determined by allocated size of this List. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs List containing inputs. Number of inputs (nargin) is determined
     * by the allocated size of this List. Input arguments may be passed as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or
     * as arrays of any supported Java type. Arguments passed as Java types are
     * converted to MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void Plot_java_example(List lhs, List rhs) throws MWException
    {
        fMCR.invoke(lhs, rhs, sPlot_java_exampleSignature);
    }

    /**
     * Provides the interface for calling the <code>Plot_java_example</code> MATLAB function 
     * where the first argument, an Object array, receives the output of the MATLAB function and
     * the second argument, also an Object array, provides the input to the MATLAB function.
     * <p>
     * Description as provided by the author of the MATLAB function:
     * </p>
     * <pre>
     * % This function plots the standard lorenz curve for a given vector of
     * % states, a selection of those states (indexes) used and indicates, whether
     * % or not the datapoints should be plotted. Is used for
     * % plot_states_historic.
     * </pre>
     * @param lhs array in which to return outputs. Number of outputs (nargout)
     * is determined by allocated size of this array. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs array containing inputs. Number of inputs (nargin) is
     * determined by the allocated size of this array. Input arguments may be
     * passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void Plot_java_example(Object[] lhs, Object[] rhs) throws MWException
    {
        fMCR.invoke(Arrays.asList(lhs), Arrays.asList(rhs), sPlot_java_exampleSignature);
    }

    /**
     * Provides the standard interface for calling the <code>Plot_java_example</code> MATLAB function with 
     * 2 comma-separated input arguments.
     * Input arguments may be passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     *
     * <p>
     * Description as provided by the author of the MATLAB function:
     * </p>
     * <pre>
     * % This function plots the standard lorenz curve for a given vector of
     * % states, a selection of those states (indexes) used and indicates, whether
     * % or not the datapoints should be plotted. Is used for
     * % plot_states_historic.
     * </pre>
     * @param rhs The inputs to the MATLAB function.
     * @return Array of length nargout containing the function outputs. Outputs
     * are returned as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>. Each output array
     * should be freed by calling its <code>dispose()</code> method.
     * @throws MWException An error has occurred during the function call.
     */
    public Object[] Plot_java_example(Object... rhs) throws MWException
    {
        Object[] lhs = new Object[0];
        fMCR.invoke(Arrays.asList(lhs), 
                    MWMCR.getRhsCompat(rhs, sPlot_java_exampleSignature), 
                    sPlot_java_exampleSignature);
        return lhs;
    }
}
