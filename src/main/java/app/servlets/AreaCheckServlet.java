package app.servlets;

import app.models.Point;
import utils.DataBean;
import utils.NV;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Deque;
import java.util.NoSuchElementException;

public class AreaCheckServlet extends HttpServlet {
    private static final String wrongFormat = "Неверный формат данных";
    private static final String inZone = "В зоне";
    private static final String outZone = "Не в зоне";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        final String x = req.getParameter("X");
        final String y = req.getParameter("Y");
        final String r = req.getParameter("R");
        final String unique = req.getParameter("unique"); //for check reload
        final boolean isFromCanvas = Integer.parseInt(req.getParameter("isFromCanvas")) == 1;
        Point point;
        if (!(x == null || y == null || r == null) &&
                (isFromCanvas && NV.isValidNumbersFromCanvas(x, y, r) ||
                        !isFromCanvas && NV.isValidNumbers(x, y, r))
        ) {
            final double X = Double.parseDouble(x);
            final double Y = Double.parseDouble(y);
            final double R = Double.parseDouble(r);
            //check area
            if (X < 0) {
                if (Y >= 0) {
                    if (Math.pow(X, 2) + Math.pow(Y, 2) <= Math.pow(R, 2)) {
                        point = new Point(x, y, r, inZone, unique);
                    } else {
                        point = new Point(x, y, r, outZone, unique);
                    }
                } else {
                    if (X < R  && Y < R) {
                        point = new Point(x, y, r, inZone, unique);
                    } else {
                        point = new Point(x, y, r, outZone, unique);
                    }
                }
            } else {
                if (Y > 0) {
                    point = new Point(x, y, r, outZone, unique);
                } else {
                    if (R > 2*X - Y) {
                        point = new Point(x, y, r, inZone, unique);
                    } else {
                        point = new Point(x, y, r, outZone, unique);
                    }
                }
            }
        } else {
            point = new Point(x, y, r, wrongFormat, unique);
        }

        Deque<Point> data = ((DataBean) req.getSession().getAttribute("DataBean")).getData();

        try {
            Point last = data.getFirst();
            if (!last.equals(point)) //add if not reload page
                data.addFirst(point);
        } catch (NoSuchElementException e) {
            data.addFirst(point);
        }
        RequestDispatcher dispatcher = req.getRequestDispatcher("resultPage.jsp");
        dispatcher.forward(req, resp);
    }
}
