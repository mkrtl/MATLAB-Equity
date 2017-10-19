/*
 * MATLAB Compiler: 6.4 (R2017a)
 * Date: Thu Sep 28 11:22:30 2017
 * Arguments: 
 * "-B""macro_default""-W""java:Test,Class1""-T""link:lib""-d""C:\\Users\\Max\\Documents\\Werkstudentenstelle\\Klassenansatz_GitHub\\Test\\for_testing""class{Class1:C:\\Users\\Max\\Documents\\Werkstudentenstelle\\Klassenansatz_GitHub\\GUI\\plot_states_historic.m}"
 */

package Test;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class TestMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "Test_1A4D462976896656F884658FC9090185";
    
    /** Component name */
    private static final String sComponentName = "Test";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(TestMCRFactory.class)
        );
    
    
    private TestMCRFactory()
    {
        // Never called.
    }
    
    public static MWMCR newInstance(MWComponentOptions componentOptions) throws MWException
    {
        if (null == componentOptions.getCtfSource()) {
            componentOptions = new MWComponentOptions(componentOptions);
            componentOptions.setCtfSource(sDefaultComponentOptions.getCtfSource());
        }
        return MWMCR.newInstance(
            componentOptions, 
            TestMCRFactory.class, 
            sComponentName, 
            sComponentId,
            new int[]{9,2,0}
        );
    }
    
    public static MWMCR newInstance() throws MWException
    {
        return newInstance(sDefaultComponentOptions);
    }
}
