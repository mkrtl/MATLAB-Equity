/*
 * MATLAB Compiler: 6.4 (R2017a)
 * Date: Wed Oct 04 22:39:11 2017
 * Arguments: 
 * "-B""macro_default""-W""java:Plot_java_example,Plot_java_test""-T""link:lib""-d""C:\\Users\\Max\\Documents\\Werkstudentenstelle\\Klassenansatz_GitHub\\Plot_java_example\\for_testing""class{Plot_java_test:C:\\Users\\Max\\Documents\\Werkstudentenstelle\\Klassenansatz_GitHub\\Plot_java_example.m}"
 */

package Plot_java_example;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class Plot_java_exampleMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "Plot_java_ex_A3FA746490DFB22D44221D02B09BB4C6";
    
    /** Component name */
    private static final String sComponentName = "Plot_java_example";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(Plot_java_exampleMCRFactory.class)
        );
    
    
    private Plot_java_exampleMCRFactory()
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
            Plot_java_exampleMCRFactory.class, 
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
