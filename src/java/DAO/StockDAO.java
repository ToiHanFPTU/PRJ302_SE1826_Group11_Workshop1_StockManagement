/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DBUtils.utils;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Stock;

public class StockDAO extends utils {
    private static final String GET_ALL_STOCKS = "SELECT ticker, name, sector, price, status FROM tblStocks";
    public List<Stock> ListStock() throws Exception{
        List<Stock> stock = new ArrayList<>();
        getConnection();
        try (
             PreparedStatement ps = connection.prepareStatement(GET_ALL_STOCKS);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String ticker = rs.getString("ticker").trim();
                String name = rs.getString("name");
                String sector = rs.getString("sector");
                double price = rs.getDouble("price");
                int status = rs.getInt("status");

                stock.add(new Stock(ticker, name, sector, price, status));
            }
        }
        return stock;
    }
    public boolean createStock(Stock stock) throws Exception {
    String sql = "INSERT INTO tblStocks(ticker, name, sector, price, status) VALUES (?, ?, ?, ?, ?)";
    getConnection();
    try (
         PreparedStatement ps = connection.prepareStatement(sql)) {

        ps.setString(1, stock.getTicker());
        ps.setString(2, stock.getName());
        ps.setString(3, stock.getSector());
        ps.setDouble(4, stock.getPrice());
        ps.setInt(5, stock.getStatus());

        int rows = ps.executeUpdate();
        return rows > 0;
    }
}
    public boolean deleteStock(String ticker) throws Exception {
    String sql = "DELETE FROM tblStocks WHERE ticker = ?";
    getConnection();
    try (
         PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, ticker);
        int rows = ps.executeUpdate();
        return rows > 0;
    }
}
    public boolean updateStock(Stock stock) throws Exception {
    String sql = "UPDATE tblStocks SET name = ?, sector = ?, price = ?, status = ? WHERE ticker = ?";
    getConnection();
    try (
         PreparedStatement ps = connection.prepareStatement(sql)) {

        ps.setString(1, stock.getName());
        ps.setString(2, stock.getSector());
        ps.setDouble(3, stock.getPrice());
        ps.setInt(4, stock.getStatus());
        ps.setString(5, stock.getTicker());

        int rows = ps.executeUpdate();
        return rows > 0;
    }
  }
    public List<Stock> searchStock(String keyword) throws Exception {
    List<Stock> result = new ArrayList<>();
    String sql = "SELECT ticker, name, sector, price, status FROM Stock "
               + "WHERE ticker LIKE ? OR name LIKE ? OR sector LIKE ?";
    
    getConnection();
    try (
         PreparedStatement ps = connection.prepareStatement(sql)) {

        String searchValue = "%" + keyword + "%";
        ps.setString(1, searchValue);
        ps.setString(2, searchValue);
        ps.setString(3, searchValue);

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                result.add(new Stock(
                    rs.getString("ticker"),
                    rs.getString("name"),
                    rs.getString("sector"),
                    rs.getDouble("price"),
                    rs.getInt("status")
                ));
            }
        }
    }
    return result;
 }   

    public boolean isTickerExist(String ticker) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
