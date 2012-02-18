
import javax.swing.JPanel;

import java.awt.Graphics;
import java.awt.Color;

public class DYPLCanvas extends JPanel
{

    private PaintCanvas canvas = null;
    private boolean[][] matrix = null;

    public DYPLCanvas()
    {
	super(null);
	setBackground(Color.lightGray);
	canvas = new PaintCanvas();
	matrix = new boolean[PaintCanvas.CANVAS_PIXEL_WIDTH][];
	for (int x = 0; x < PaintCanvas.CANVAS_PIXEL_WIDTH; ++x)
	    {
		matrix[x] = new boolean[PaintCanvas.CANVAS_PIXEL_HEIGHT];
		for (int y = 0; y < PaintCanvas.CANVAS_PIXEL_HEIGHT; ++y)
		    {
			matrix[x][y] = false;
		    }
	    }
	add(canvas);
    }

    public void setPixel(int x, int y)
    {
	if (x < 0 || x >= PaintCanvas.CANVAS_PIXEL_WIDTH
	    || y < 0 || y >= PaintCanvas.CANVAS_PIXEL_HEIGHT)
	    {
		return;
	    }
	matrix[x][y] = true;
    }

    public void unsetPixel(int x, int y)
    {
	if (x < 0 || x >= PaintCanvas.CANVAS_PIXEL_WIDTH
	    || y < 0 || y >= PaintCanvas.CANVAS_PIXEL_HEIGHT)
	    {
		return;
	    }
	matrix[x][y] = false;
    }

    public void center()
    {
	canvas.setBounds((getWidth() / 2) - (PaintCanvas.CANVAS_PIXEL_WIDTH / 2),
			 (getHeight() / 2) - (PaintCanvas.CANVAS_PIXEL_HEIGHT / 2),
			 PaintCanvas.CANVAS_PIXEL_WIDTH,
			 PaintCanvas.CANVAS_PIXEL_HEIGHT);
    }

    private class PaintCanvas extends JPanel
    {

	public static final int CANVAS_PIXEL_WIDTH = 300;
	public static final int CANVAS_PIXEL_HEIGHT = 300;
	
	protected PaintCanvas()
	{
	    super(null);
	    setBounds(50, 10, CANVAS_PIXEL_WIDTH, CANVAS_PIXEL_HEIGHT);
	}

	protected void paintComponent(Graphics g)
	{
	    for (int x = 0; x < CANVAS_PIXEL_WIDTH; ++x)
		{
		    for (int y = 0; y < CANVAS_PIXEL_HEIGHT; ++y)
			{
			    g.setColor((matrix[x][y] ? Color.black : Color.white));
			    g.fillRect(x, y, x + 1, y + 1);
			}
		}
	}

    } // PaintCanvas

} // DYPLCanvas