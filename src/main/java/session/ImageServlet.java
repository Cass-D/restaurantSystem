package session;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

/**
 * Created by Administrator on 2016/5/19.
 */
public class ImageServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException{
        BufferedImage bufferedImage = new BufferedImage(88,20,BufferedImage.TYPE_3BYTE_BGR);
        Graphics graphics = bufferedImage.getGraphics();
        Color color = new Color(200,150,255);
        graphics.setColor(color);
        graphics.fillRect(0,0,88,20);
        char [] chars = "1234567890".toCharArray();
        Random random = new Random();
        int leng = chars.length;
        int index;
        int code = 0;

        index = random.nextInt(leng);
        graphics.setColor(new Color(random.nextInt(88),random.nextInt(188),random.nextInt(255)));
        graphics.drawString(chars[index]+"",(0*20)+10,16);
        code += Integer.parseInt(String.valueOf(chars[index]));

        graphics.setColor(new Color(random.nextInt(80),random.nextInt(160),random.nextInt(240)));
        graphics.drawString("+",(1*20)+10,16);

        index = random.nextInt(leng);
        graphics.setColor(new Color(random.nextInt(80),random.nextInt(160),random.nextInt(240)));
        graphics.drawString(chars[index]+"",(2*20)+10,16);
        code += Integer.parseInt(String.valueOf(chars[index]));

        graphics.setColor(new Color(random.nextInt(80),random.nextInt(160),random.nextInt(240)));
        graphics.drawString("=",(3*20)+10,16);

        request.getSession().setAttribute("code",String.valueOf(code));
        ImageIO.write(bufferedImage,"JPG",response.getOutputStream());
    }
}
