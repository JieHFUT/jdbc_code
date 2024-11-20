package utils3;

import utils2.JdbcUtils2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * ClassName: BaseDao
 * Package: utils2
 * Description:
 * TODO: 封装两个方法，一个是简化 DQL，即查询语句
 *                一个是简化 非DQL,即非查询语句
 *
 * @Author jieHFUT
 * @Create 2024/11/20 23:01
 * @Version 1.0
 */
public abstract class BaseDao {

    /**
     * 封装简化 非DQL 语句
     * @param sql 传入的 sql 语句
     * @param params 可变参数，即传递占位符的数据
     * @return
     */
    public int execute(String sql, Object... params) throws SQLException {
        //1.获取一个连接
        Connection connection = JdbcUtils2.getConnection();
        //2.构建传送工具
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        //3.占位符赋值
        for (int i = 1; i <= params.length; i++) {
            preparedStatement.setObject(i , params[i]);
        }
        //4.执行 sql 语句
        int ret = preparedStatement.executeUpdate();
        //5.是否需要回收连接需要考虑是不是事务
        if (connection.getAutoCommit()) {
            //没有开启事务，正常回收连接 (也就是没有两个动作绑在一个事务上)
            JdbcUtils2.freeConnection();
        }
        // 开启事务，就由业务层自己去处理
        return ret;
    }













}
