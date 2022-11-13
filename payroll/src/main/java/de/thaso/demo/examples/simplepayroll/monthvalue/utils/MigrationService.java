package de.thaso.demo.examples.simplepayroll.monthvalue.utils;

import liquibase.Contexts;
import liquibase.LabelExpression;
import liquibase.Liquibase;
import liquibase.database.Database;
import liquibase.database.DatabaseFactory;
import liquibase.database.jvm.JdbcConnection;
import liquibase.resource.ClassLoaderResourceAccessor;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.sql.Connection;
import java.sql.DriverManager;

@ApplicationScoped
public class MigrationService {
    private static final Logger LOGGER = Logger.getLogger("MigrationService");

    public void checkMigration() {
        LOGGER.info("==> check migartion ...");
        try {
            migrateDB();
        } catch (Throwable e) {
            LOGGER.error("==> ERROR: running migration!");
            throw new RuntimeException(e);
        }
    }

    private void migrateDB() throws Throwable {
        Connection connection = openConnection();
        Database database = DatabaseFactory.getInstance().findCorrectDatabaseImplementation(new JdbcConnection(connection));
        Liquibase liquibase = new Liquibase("/liquibase/dbchangelog.xml", new ClassLoaderResourceAccessor(), database);
        liquibase.update(new Contexts(), new LabelExpression());
    }

    private Connection openConnection() {

        LOGGER.info("==> open connection ...");
        Connection con = null;
        try {
            Class.forName("com.simba.cassandra.jdbc42.Driver");
            con = DriverManager.getConnection("jdbc:cassandra://database:9042/payroll;DefaultKeyspace=payroll;datacenter1");
        } catch (Throwable e) {
            LOGGER.info("==> ... could not open connection");
            throw new RuntimeException(e);
        }
        LOGGER.info("==> ... connection opened");
        return con;
    }
}
