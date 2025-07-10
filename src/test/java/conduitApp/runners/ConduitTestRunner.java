package conduitApp.runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class ConduitTestRunner {

    /*
    @Karate.Test
    Karate testParallel(){
        return Karate.run("classpath:conduitApp/com")
                .tags("@delspecific")
                .relativeTo(getClass());
    }*/


    @Test
    void parallelTest(){
        Results results = Runner.path("classpath:conduitApp/com/features")
                .tags("@del")
                .configDir("classpath:")
                .parallel(1);

        System.out.println("📊 REPORT: file://" + results.getReportDir() + "/karate-summary.html");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
