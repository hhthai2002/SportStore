package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import dbcontext.DBUtil;
import entity.Cart;
import entity.Shoes;

public class ProductDAO {
    public ArrayList<Shoes> allShoes() {
        ArrayList<Shoes> list = new ArrayList<Shoes>();
        DBUtil db = DBUtil.getInstance();
        String sql = "Select * from product";
        Connection con = null;
        try {
            con = db.getConnection();
            PreparedStatement statement = con.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                list.add(new Shoes(rs.getInt("pid"), rs.getString("pname"), rs.getDouble("price"),
                        rs.getString("preview")));
            }
        } catch (Exception e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                DBUtil.closeConnection(con);
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return list;
    }

    public Shoes getProduct(int id) {
        String sql = "";
        DBUtil db = DBUtil.getInstance();
        PreparedStatement pst;

        ResultSet rs;
        Connection con = null;
        Shoes s1 = null;
        try {
            sql = "SELECT * from product where id=? ";

            pst = con.prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();

            while (rs.next()) {
                s1 = new Shoes();
                s1.setShoesID(rs.getInt("pid"));
                s1.setShoesName(rs.getString("pname"));
                s1.setPrice(rs.getDouble("price"));
                s1.setCover(rs.getString("preview"));
            }
        } catch (Exception e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                DBUtil.closeConnection(con);
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }

        return s1;
    }

    public ArrayList<Shoes> searchShoes(String sname) {
        ArrayList<Shoes> slist = new ArrayList<Shoes>();
        String sid = "";

        DBUtil db = DBUtil.getInstance();
        String sql = "select * from product where UPPER(pname) LIKE UPPER('%" + sname + "%')";

        Connection con = null;
        try {
            con = db.getConnection();
            PreparedStatement statement = con.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                slist.add(new Shoes(rs.getInt("pid"), rs.getString("pname"), rs.getDouble("price"),
                        rs.getString("preview")));
            }
        } catch (Exception e) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                DBUtil.closeConnection(con);
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return slist;
    }

    public double getTotalCartPrice(ArrayList<Cart> cartList) throws Exception {
        double sum = 0;
        String sql = "";
        DBUtil db = DBUtil.getInstance();
        PreparedStatement pst;

        ResultSet rs;
        Connection con = null;
        try {
            con = db.getConnection();
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    sql = "select price from product where pid=?";
                    pst = con.prepareStatement(sql);
                    pst.setInt(1, item.getShoesID());
                    rs = pst.executeQuery();
                    while (rs.next()) {
                        sum += rs.getDouble("price") * item.getQuantity();
                    }

                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        } finally {
            try {
                DBUtil.closeConnection(con);
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return sum;
    }

    public ArrayList<Cart> getCartProducts(ArrayList<Cart> cartList) throws Exception {
        ArrayList<Cart> shoeslist = new ArrayList<>();
        String sql = "";
        DBUtil db = DBUtil.getInstance();
        PreparedStatement pst;

        ResultSet rs;
        Connection con = null;
        try {
            con = db.getConnection();
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                    sql = "select * from product where pid=?";
                    pst = con.prepareStatement(sql);
                    pst.setInt(1, item.getShoesID());
                    rs = pst.executeQuery();
                    while (rs.next()) {
                        Cart row = new Cart();
                        row.setShoesID(rs.getInt("pid"));
                        row.setShoesName(rs.getString("pname"));
                        row.setPrice(rs.getDouble("price"));
                        row.setCover(rs.getString("preview"));
                        row.setQuantity(item.getQuantity());
                        shoeslist.add(row);
                    }

                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        } finally {
            try {
                DBUtil.closeConnection(con);
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return shoeslist;
    }

    public boolean insertPurchase(int userId, int productId, int quantity) {
        boolean result = false;
        DBUtil db = DBUtil.getInstance();
        Connection con = null;
        PreparedStatement pst = null;

        try {
            con = db.getConnection();
            String query = "INSERT INTO purchase_history (user_id, product_id, quantity) VALUES (?, ?, ?)";
            pst = con.prepareStatement(query);
            pst.setInt(1, userId);
            pst.setInt(2, productId);
            pst.setInt(3, quantity);
            result = pst.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            try {
                if (pst != null) {
                    pst.close();
                }
                DBUtil.closeConnection(con);
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return result;
    }

    public ArrayList<Cart> getProductsPurchasedByUser(String userId) {
        ArrayList<Cart> purchasedProducts = new ArrayList<>();
        String sql = "SELECT p.pid, p.pname, p.price, p.preview, ph.quantity " +
                "FROM product p " +
                "JOIN purchase_history ph ON p.pid = ph.product_id " +
                "WHERE ph.user_id = ?";
        DBUtil db = DBUtil.getInstance();
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, userId);
            rs = pst.executeQuery();

            while (rs.next()) {
                Cart cartItem = new Cart();
                cartItem.setShoesID(rs.getInt("pid"));
                cartItem.setShoesName(rs.getString("pname"));
                cartItem.setPrice(rs.getDouble("price"));
                cartItem.setCover(rs.getString("preview"));
                cartItem.setQuantity(rs.getInt("quantity"));
                purchasedProducts.add(cartItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pst != null) {
                    pst.close();
                }
                DBUtil.closeConnection(con);
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return purchasedProducts;
    }

    public double getTotalPriceOfProductsPurchasedByUser(String userId) {
        double totalPrice = 0;
        String sql = "SELECT SUM(p.price * ph.quantity) AS total_price " +
                "FROM product p " +
                "JOIN purchase_history ph ON p.pid = ph.product_id " +
                "WHERE ph.user_id = ?";
        DBUtil db = DBUtil.getInstance();
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            con = db.getConnection();
            pst = con.prepareStatement(sql);
            pst.setString(1, userId);
            rs = pst.executeQuery();

            if (rs.next()) {
                totalPrice = rs.getDouble("total_price");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pst != null) {
                    pst.close();
                }
                DBUtil.closeConnection(con);
            } catch (SQLException e) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        return totalPrice;
    }


}
