package jdbc_base;

import com.mysql.cj.jdbc.Driver;

import java.sql.*;

/**
 * 1.注册驱动
 * 2.获取连接
 * 3.创建 Statement
 * 4.构造 sql 语句
 * 5.执行 sql 语句，获取结果
 * 6.结果解析
 * 7.关闭连接
 */
public class JdbcStatementQuaryPart {

    public static void main(String[] args) throws SQLException {

        // 1.注册驱动 使用 com.mysql.cj.jdbc.Driver
        DriverManager.registerDriver(new Driver());


        //2.获取连接
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/atchery",
                "root",
                "959452");

        //3.创建发送小车工具（预编译）
        Statement statement = connection.createStatement();

        //4.构造 sql 语句
        String sql = "select * from tuser";

        //5.发送 sql 语句
        ResultSet resultSet = statement.executeQuery(sql);

        //6.对查询的结果进行解析
        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String account = resultSet.getString("account");
            String password = resultSet.getString("password");

            String ret = "id=" + id + ", account=" + account + ", password=" + password;
            System.out.println(ret);
        }

        //7.关闭资源
        resultSet.close();
        statement.close();
        connection.close();


    }
}
