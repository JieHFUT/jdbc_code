package druid;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.pool.DruidPooledConnection;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * ClassName: DruidUsePart
 * Package: druid 德鲁伊
 * Description: 直接使用代码来设置连接池的参数信息
 * 1.创建一个 druid 连接池对象
 * 2.设置连接池参数
 * 3.获取连接
 * 4.回收连接
 * @Author jieHFUT
 * @Create 2024/11/20 21:54
 * @Version 1.0
 */
public class DruidUsePart {

    public void testDruid() throws SQLException {
        //1.创建一个 druid 连接池对象
        DruidDataSource druidDataSource = new DruidDataSource();
        //2.设置连接池参数
        // 必须的参数，连接数据库驱动类的全限定符号：url  user  password
        // 非必须的参数：连接池的数量，连接池的最大数量...
        druidDataSource.setUrl("jdbc:mysql://127.0.0.1:3306/atchery");
        druidDataSource.setUsername("root");
        druidDataSource.setPassword("959452");
        druidDataSource.setDriverClassName("com.mysql.jdbc.Driver");// 帮助我们进行驱动注册和获取连接

        druidDataSource.setInitialSize(5);
        druidDataSource.setMaxActive(10);
        //3.获取连接
        Connection connection = druidDataSource.getConnection();

        // 进行 CURD

        //4.回收连接
        connection.close();
    }
}
