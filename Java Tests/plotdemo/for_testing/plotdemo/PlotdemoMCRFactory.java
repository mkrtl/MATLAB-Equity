/*
 * MATLAB Compiler: 6.4 (R2017a)
 * Date: Mon Oct 09 22:25:21 2017
 * Arguments: 
 * "-B""macro_default""-W""java:plotdemo,plotter""-T""link:lib""-d""C:\\Users\\Max\\Documents\\Werkstudentenstelle\\Klassenansatz_GitHub\\plotdemo\\for_testing""class{plotter:C:\\Users\\Max\\Documents\\Werkstudentenstelle\\Klassenansatz_GitHub\\drawplot.m}"
 */

package plotdemo;

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;

/**
 * <i>INTERNAL USE ONLY</i>
 */
public class PlotdemoMCRFactory
{
   
    
    /** Component's uuid */
    private static final String sComponentId = "plotdemo_6CA47C734ED80687701CE0E8D4EC0849";
    
    /** Component name */
    private static final String sComponentName = "plotdemo";
    
   
    /** Pointer to default component options */
    private static final MWComponentOptions sDefaultComponentOptions = 
        new MWComponentOptions(
            MWCtfExtractLocation.EXTRACT_TO_CACHE, 
            new MWCtfClassLoaderSource(PlotdemoMCRFactory.class)
        );
    
    
    private PlotdemoMCRFactory()
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
            PlotdemoMCRFactory.class, 
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
