package jdbc_bank.first_bank;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * ClassName: BankDao
 * Package: jdbc_expand
 * Description:
 *
 * @Author jieHFUT
 * @Create 2024/11/20 20:43
 * @Version 1.0
 */
public class BankDao {


    /**
     *
     * 加钱的方法
     * @param account 需要加钱的账户
     * @param money 加钱的数额
     */
    public void addMoney(String account, int money) throws ClassNotFoundException, SQLException {
        //1.注册驱动
        Class.forName("com.mysql.cj.jdbc.Driver");
        //2.获取连接
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/atchery",
                "root",
                "959452");
        //3.构建转运工具
        //4.构建 sql 语句，执行 sql 语句
        String sql = "update t_bank set money = money + ? where account = ?;";
        PreparedStatement statement = connection.prepareStatement(sql);

        statement.setInt(1, money);
        statement.setString(2, account);
        int ret = statement.executeUpdate();
        //5.对结果进行解析
        if (ret != 0) {
            System.out.println("账户 "+ account +" 到账" + money + "元");
        } else {
            System.out.println("收钱方转账失败");
        }
        //6.关闭资源
        statement.close();
        connection.close();
    }


    /**
     * 减钱的方法
     * @param account 需要减钱的账户
     * @param money 减钱的数额
     */
    public void subMoney(String account, int money) throws ClassNotFoundException, SQLException {
        //1.注册驱动
        Class.forName("com.mysql.cj.jdbc.Driver");
        //2.获取连接
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/atchery",
                "root",
                "959452");
        //3.构建转运工具
        //4.构建 sql 语句，执行 sql 语句
        String sql = "update t_bank set money = money - ? where account = ?;";
        PreparedStatement statement = connection.prepareStatement(sql);

        statement.setInt(1, money);
        statement.setString(2, account);
        int ret = statement.executeUpdate();
        //5.对结果进行解析
        if (ret != 0) {
            System.out.println("账户 "+ account +" 转出" + money + "元");
        } else {
            System.out.println("发钱方转账失败");
        }
        //6.关闭资源
        statement.close();
        connection.close();
    }
}
