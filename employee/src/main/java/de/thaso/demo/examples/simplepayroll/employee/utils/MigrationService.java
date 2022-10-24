package de.thaso.demo.examples.simplepayroll.employee.utils;

import io.quarkus.liquibase.LiquibaseFactory;
import liquibase.Contexts;
import liquibase.LabelExpression;
import liquibase.Liquibase;
import liquibase.Scope;
import liquibase.database.Database;
import liquibase.database.DatabaseFactory;
import liquibase.database.jvm.JdbcConnection;
import liquibase.resource.ClassLoaderResourceAccessor;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.HashMap;
import java.util.Map;

@ApplicationScoped
public class MigrationService {
    private static final Logger LOGGER = Logger.getLogger("MigrationService");

//    @Inject
//    LiquibaseFactory liquibaseFactory;

    public void checkMigration() {
        LOGGER.info("==> check migartion ...");
/*
        try(Liquibase liquibase = liquibaseFactory.createLiquibase()) {
            List<ChangeSetStatus> status = liquibase.getChangeSetStatuses(
                    liquibaseFactory.createContexts(),
                    liquibaseFactory.createLabels());
        } catch (LiquibaseException exception) {
            throw new RuntimeException(exception);
        }
*/
        try {
            Thread.sleep(120000);
            LOGGER.info("==> after waiting 2 minutes ...");
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
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
        Liquibase liquibase = new liquibase.Liquibase("/liquibase/dbchangelog.xml", new ClassLoaderResourceAccessor(), database);
        liquibase.update(new Contexts(), new LabelExpression());
    }

    private void doMigration() {
        LOGGER.info("==> migrate db ...");
        Map<String, Object> config = new HashMap<>();
        try {
            Scope.child(config, () -> {
                Connection connection = openConnection(); //your openConnection logic
                Database database = DatabaseFactory.getInstance().findCorrectDatabaseImplementation(new JdbcConnection(connection));
                Liquibase liquibase = new Liquibase("/liquibase/dbchangelog.xml", new ClassLoaderResourceAccessor(), database);
                liquibase.update(new Contexts(), new LabelExpression());
            });
        } catch (Exception e) {
            LOGGER.info("==> ... could not migrate db");
            throw new RuntimeException(e);
        }
        LOGGER.info("==> ... db migrated");
    }

    private Connection openConnection() {

        LOGGER.info("==> open connection ...");
        Connection con = null;
        try {
            Class.forName("com.simba.cassandra.jdbc42.Driver");
            con = DriverManager.getConnection("jdbc:cassandra://database:9042/employee;datacenter01;User=cassandra;Password=cassandra");
        } catch (Throwable e) {
            LOGGER.info("==> ... could not open connection");
            throw new RuntimeException(e);
        }
        LOGGER.info("==> ... connection opened");
        return con;
/*

        try(CqlSession session = CqlSession.builder().addContactPoint(new InetSocketAddress(contactPoint, port))
                .withLocalDatacenter(dataCenter).withKeyspace(keySpace).build()) {

            ResultSet rs = session.execute("select *from mytable limit 5");
            for (Row row : rs.all()) {
                System.out.println(row.getString("column_name"));
            }
        } catch(
                Exception e)

        {
            System.out.println(e.getMessage());
        }
*/
    }
}
