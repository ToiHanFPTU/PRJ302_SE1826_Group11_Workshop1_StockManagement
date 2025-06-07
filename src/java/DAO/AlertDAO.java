package DAO;

import DBUtils.utils;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Alert;

public class AlertDAO extends utils {

    public ArrayList<Alert> search(String search) throws SQLException {
        ArrayList<Alert> list = new ArrayList<>();
        try {
            getConnection();
            if (connection != null) {
                String sql = "SELECT * FROM tblAlerts WHERE userID LIKE ? OR ticker LIKE ?";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, '%' + search + '%');
                preparedStatement.setString(2, '%' + search + '%');
                resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    int alertID = resultSet.getInt("alertID");
                    String userID = resultSet.getString("userID");
                    String ticker = resultSet.getString("ticker");
                    float threshold = resultSet.getFloat("threshold");
                    String direction = resultSet.getString("direction");
                    String status = resultSet.getString("status");
                    list.add(new Alert(alertID, userID, ticker, threshold, direction, status));
                }
            }
        } catch (Exception e) {
        } finally {
            closeConnection();
        }
        return list;
    }

    public boolean createAlert(Alert alert) throws Exception {
        boolean isCreated = false;
        try {
            getConnection();
            if (connection != null) {
                String sql = "INSERT INTO tblAlerts(userID, ticker, threshold, direction) VALUES(?, ?, ?, ?)";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, alert.getUserID());
                preparedStatement.setString(2, alert.getTicker());
                preparedStatement.setFloat(3, alert.getThreshold());
                preparedStatement.setString(4, alert.getDirection());
                isCreated = preparedStatement.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return isCreated;
    }

    public boolean updateAlert(Alert alert) throws Exception {
        boolean isUpdated = false;
        try {
            getConnection();
            if (connection != null) {
                String sql = "UPDATE tblAlerts SET threshold = ?, direction = ?, status = ? WHERE alertID = ? AND userID = ?";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setFloat(1, alert.getThreshold());
                preparedStatement.setString(2, alert.getDirection());
                preparedStatement.setString(3, alert.getStatus());
                preparedStatement.setInt(4, alert.getAlertID());
                preparedStatement.setString(5, alert.getUserID());
                isUpdated = preparedStatement.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return isUpdated;
    }

    public boolean deleteAlert(int alertID) throws Exception {
        boolean isDeleted = false;
        try {
            getConnection();
            if (connection != null) {
                String sql = "DELETE FROM tblAlerts WHERE alertID = ? AND status = 'inactive'";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setInt(1, alertID);
                isDeleted = preparedStatement.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return isDeleted;
    }
    public boolean isDuplicate(String userID, String ticker, float threshold, String direction) throws Exception {
        boolean isDuplicated = false;
        try {
            getConnection();
            if (connection != null) {
                String sql = "SELECT * FROM tblAlerts WHERE userID = ? AND ticker = ? AND threshold = ? AND direction = ?";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, userID);
                preparedStatement.setString(2, ticker);
                preparedStatement.setFloat(3, threshold);
                preparedStatement.setString(4, direction);
                resultSet = preparedStatement.executeQuery();
                isDuplicated = resultSet.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnection();
        }
        return isDuplicated;
    }
    public Alert getAlertById(int alertID) throws SQLException {
        String sql = "SELECT * FROM tblAlerts WHERE alertID = ?";
        getConnection();
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, alertID);
        try {
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return new Alert(resultSet.getInt("alertID"), resultSet.getString("userID"), resultSet.getString("ticker"), resultSet.getFloat("threshold"), resultSet.getString("direction"), resultSet.getString("status"));
            }
        } catch(Exception e) {
            
        }
        return null;
    }
    
    public List<Alert> getAlertsByUser(String userID, String keyword, String direction, String status) throws SQLException {
        List<Alert> list = new ArrayList<>();
        try {
            getConnection();
            preparedStatement = connection.prepareStatement("SELECT * FROM tblAlerts WHERE userID = ? AND ticker LIKE ? AND direction LIKE ? AND status LIKE ?");
            preparedStatement.setString(1, userID);
            preparedStatement.setString(2, "%" + keyword + "%");
            preparedStatement.setString(3, "%" + direction + "%");
            preparedStatement.setString(4, "%" + status + "%");
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Alert alert = new Alert(resultSet.getInt("alertID"), resultSet.getString("userID"), resultSet.getString("ticker"), resultSet.getFloat("threshold"), resultSet.getString("direction"), resultSet.getString("status")); // mapping fields
                list.add(alert);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
