import javax.swing.JFrame;
import javax.swing.JTextArea;
import javax.swing.JButton;
import javax.swing.JPanel;
import javax.swing.JScrollPane;

import java.awt.BorderLayout;
import java.awt.FlowLayout;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

import java.lang.reflect.*;

public class DYPL extends JFrame
{

    public static final String DEFAULT_CLASS_NAME = "JythonTranslater$Jtrans";

    private DYPLCanvas canvas = null;
    private JTextArea input = new JTextArea();
    private JButton go = new JButton("Go");

    public DYPL(Translater al)
    {
        setLayout(new BorderLayout());
        setSize(400, 500);
        canvas = new DYPLCanvas();
        add(canvas);
        JPanel inptPanel = new JPanel(new BorderLayout());
        {
            input.setRows(5);
            inptPanel.add(new JScrollPane(input));
            JPanel buttonPanel = new JPanel();
            {
                al.setDYPL(this);
                buttonPanel.add(go);
                go.addActionListener(al);
            }
            inptPanel.add(buttonPanel, BorderLayout.SOUTH);
        }
        add(inptPanel, BorderLayout.SOUTH);
        setResizable(false);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setVisible(true);
        canvas.center();
    }

    /**
     * Turns pixel at point x, y on
     */
    public void setPixel(int x, int y)
    {
        canvas.setPixel(x, y);
        repaint();
    }

    /**
     * Turns pixel at point x, y off
     */
    public void unsetPixel(int x, int y)
    {
        canvas.unsetPixel(x, y);
        repaint();
    }

    /**
     * Returns the text currently in the text field
     */
    public String getCode()
    {
        return input.getText();
    }

    private static Class loadClass(String cn)
    {
        Class c = null;
        try
            {
                c = Class.forName(cn);
            }
        catch (ClassNotFoundException cnf)
            {
                System.err.println("Class " + cn +
                                   " not found... Defaulting to " +
                                   DEFAULT_CLASS_NAME);
                try
                    {
                        c = Class.forName(DEFAULT_CLASS_NAME);
                    }
                catch (ClassNotFoundException cnf2)
                    {
                        System.err.println("Default class not found. " +
                                           "Check your classpath");
                        System.exit(1);
                    }
            }
        return c;
    }

    public static void main(String[] args)
    {
        String className = DEFAULT_CLASS_NAME;
        if (args.length == 1)
            {
                className = args[0];
            }
        Class c = loadClass(className);
        Translater obj = null;
        try
            {
                obj = (Translater) c.newInstance();
            }
        catch (InstantiationException e)
            {
                System.err.println("InstantiationException: " + e);
                System.exit(3);
            }
        catch (IllegalAccessException iae)
            {
                System.err.println("Illegal access: " + iae);
                System.exit(2);
            }

        new DYPL(obj);
    }

} // DYPL