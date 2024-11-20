package jdbc_bank.second_bank;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * ClassName: BandService
 * Package: jdbc_expand
 * Description:
 *
 * @Author jieHFUT
 * @Create 2024/11/20 20:43
 * @Version 1.0
 */
public class BankService {

    /**
     * 这是一个模仿银行转账的业务
     * @param addAccount 需要加钱的账户
     * @param subAccount 需要减钱的账户
     * @param money 转账的数值
     *
     * 开始事务，将转账的两个动作添加到一个事务中去
     * 如果其中一个失败，就进行回滚
     */
    public void transfer(String addAccount, String subAccount, int money) throws SQLException, ClassNotFoundException {
        // 显示转账双方的数据
        System.out.println("addAccount = " + addAccount + "; subAccount = " + subAccount + "; money = " + money);
        BankDao bankDao = new BankDao();



        //1.注册驱动
        Class.forName("com.mysql.cj.jdbc.Driver");
        //2.获取连接
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/atchery",
                "root",
                "959452");


        try {
            // TODO: 开始事务(即关闭自动提交)
            connection.setAutoCommit(false);

            // 对向外转钱的一方进行扣钱
            bankDao.subMoney("subAccount", 500, connection);
            // 对到账的一方进行加钱
            bankDao.addMoney("addAccount", 500, connection);


            //TODO: 关闭事务
            connection.commit();
        } catch (Exception e) {
            //事务回滚
            connection.rollback();
            //抛出异常信息
            throw e;
        } finally {
            connection.close();
        }

    }
}
