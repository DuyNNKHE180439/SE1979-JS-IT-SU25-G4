
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Bed;

/**
 *
 * @author ADMIN
 */
public class BedDAO {

    public static List<Bed> getBedsByRoomID(int roomID) {
        DBContext db = DBContext.getInstance();
        List<Bed> bedList = new ArrayList<>();

        try {
            String sql = "SELECT * FROM Beds WHERE RoomID = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, roomID);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Bed bed = new Bed();
                bed.setBedID(rs.getInt("BedID"));
                bed.setRoomID(rs.getInt("RoomID"));
                bed.setBedNumber(rs.getString("BedNumber"));
                bed.setPosition(rs.getString("Position"));
                bed.setPrice(rs.getBigDecimal("Price"));
                bed.setStatus(rs.getString("Status"));

                bedList.add(bed);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bedList;
    }

    public static Bed getBedById(int bedId) {
        Bed bed = null;
        try {
            DBContext db = DBContext.getInstance();
            String sql = "SELECT BedID, RoomID, BedNumber, Position, Price, Status FROM Beds WHERE BedID = ?";
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setInt(1, bedId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                bed = new Bed();
                bed.setBedID(rs.getInt("BedID"));
                bed.setRoomID(rs.getInt("RoomID"));
                bed.setBedNumber(rs.getString("BedNumber"));
                bed.setPosition(rs.getString("Position"));
                bed.setPrice(rs.getBigDecimal("Price"));
                bed.setStatus(rs.getString("Status"));
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bed;
    }

}
