package utils;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * ClassName: JdbcCrudPart
 * Package: utils
 * Description:
 *
 * @Author jieHFUT
 * @Create 2024/11/20 22:29
 * @Version 1.0
 */
public class JdbcCrudPart {

    public void testInsert() throws SQLException {

        Connection connection = JdbcUtils.getConnection();

        // 数据库的 CRUD 操作 ...

        JdbcUtils.freeConnection(connection);
    }
}
