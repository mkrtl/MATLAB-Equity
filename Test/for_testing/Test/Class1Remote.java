/*
 * MATLAB Compiler: 6.4 (R2017a)
 * Date: Thu Sep 28 11:22:30 2017
 * Arguments: 
 * "-B""macro_default""-W""java:Test,Class1""-T""link:lib""-d""C:\\Users\\Max\\Documents\\Werkstudentenstelle\\Klassenansatz_GitHub\\Test\\for_testing""class{Class1:C:\\Users\\Max\\Documents\\Werkstudentenstelle\\Klassenansatz_GitHub\\GUI\\plot_states_historic.m}"
 */

package Test;

import com.mathworks.toolbox.javabuilder.pooling.Poolable;
import java.util.List;
import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * The <code>Class1Remote</code> class provides a Java RMI-compliant interface to MATLAB 
 * functions. The interface is compiled from the following files:
 * <pre>
 *  C:\Users\Max\Documents\Werkstudentenstelle\Klassenansatz_GitHub\GUI\plot_states_historic.m
 * </pre>
 * The {@link #dispose} method <b>must</b> be called on a <code>Class1Remote</code> 
 * instance when it is no longer needed to ensure that native resources allocated by this 
 * class are properly freed, and the server-side proxy is unexported.  (Failure to call 
 * dispose may result in server-side threads not being properly shut down, which often 
 * appears as a hang.)  
 *
 * This interface is designed to be used together with 
 * <code>com.mathworks.toolbox.javabuilder.remoting.RemoteProxy</code> to automatically 
 * generate RMI server proxy objects for instances of Test.Class1.
 */
public interface Class1Remote extends Poolable
{
    /**
     * Provides the standard interface for calling the <code>plot_states_historic</code> 
     * MATLAB function with 1 input argument.  
     *
     * Input arguments to standard interface methods may be passed as sub-classes of 
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of any 
     * supported Java type (i.e. scalars and multidimensional arrays of any numeric, 
     * boolean, or character type, or String). Arguments passed as Java types are 
     * converted to MATLAB arrays according to default conversion rules.
     *
     * All inputs to this method must implement either Serializable (pass-by-value) or 
     * Remote (pass-by-reference) as per the RMI specification.
     *
     * Documentation as provided by the author of the MATLAB function:
     * <pre>
     * % PLOT_STATES_HISTORIC MATLAB code for plot_states_historic.fig
     * %      PLOT_STATES_HISTORIC, by itself, creates a new PLOT_STATES_HISTORIC or 
     * raises the existing
     * %      singleton*.
     * %
     * %      H = PLOT_STATES_HISTORIC returns the handle to a new PLOT_STATES_HISTORIC 
     * or the handle to
     * %      the existing singleton*.
     * %
     * %      PLOT_STATES_HISTORIC('CALLBACK',hObject,eventData,handles,...) calls the 
     * local
     * %      function named CALLBACK in PLOT_STATES_HISTORIC.M with the given input 
     * arguments.
     * %
     * %      PLOT_STATES_HISTORIC('Property','Value',...) creates a new 
     * PLOT_STATES_HISTORIC or raises the
     * %      existing singleton*.  Starting from the left, property value pairs are
     * %      applied to the GUI before plot_states_historic_OpeningFcn gets called.  An
     * %      unrecognized property name or invalid value makes property application
     * %      stop.  All inputs are passed to plot_states_historic_OpeningFcn via 
     * varargin.
     * %
     * %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
     * %      instance to run (singleton)".
     * %
     * % See also: GUIDE, GUIDATA, GUIHANDLES
     * </pre>
     *
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the MATLAB function.
     *
     * @return Array of length nargout containing the function outputs. Outputs are 
     * returned as sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>. 
     * Each output array should be freed by calling its <code>dispose()</code> method.
     *
     * @throws java.rmi.RemoteException An error has occurred during the function call or 
     * in communication with the server.
     */
    public Object[] plot_states_historic(int nargout, Object... rhs) throws RemoteException;
  
    /** 
     * Frees native resources associated with the remote server object 
     * @throws java.rmi.RemoteException An error has occurred during the function call or in communication with the server.
     */
    void dispose() throws RemoteException;
}
