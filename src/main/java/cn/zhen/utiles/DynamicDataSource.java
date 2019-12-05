package cn.zhen.utiles;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

public class DynamicDataSource extends AbstractRoutingDataSource
{
    private static final ThreadLocal<String> key = new ThreadLocal<String>();

    /**
     * 设置数据源
     * @param dbSource 数据源名称
     */
    public static void setDataSource(String dbSource) {
        if (dbSource.equals(DataSource.slave)) {
            int random = (int)(Math.random() * 2) <= 0 ? 1 : 2;
            dbSource = DataSource.slave + random;
        }
        key.set(dbSource);
    }


    /**
     * 获取数据源
     * @return
     */
    public static String getDataSource() {
        return key.get();
    }

    /**
     * 清除数据源
     */
    public static void clearDataSource(){
        key.remove();
    }

    @Override
    protected Object determineCurrentLookupKey() {
        return key.get();
    }
}
