package conduitApp.utils;

import com.github.javafaker.Faker;
import net.minidev.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class DataGenerator {
    static Faker faker = new Faker();

    public static String getRandomEmail(){
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0,100) + "@test.com";
        return email;
    }

    public static String getRandomUsername(){
        String username = faker.name().username();
        return username;
    }

    public static JSONObject getArticleRequest(){
        String title = faker.harryPotter().character();
        String description = faker.harryPotter().quote();
        String body = faker.harryPotter().house();
        //String tagList = faker.harryPotter().house().toLowerCase();
        List<String> tagList = new ArrayList<>();
        for(int i=0; i<3; i++){
            tagList.add(faker.harryPotter().spell());
        }
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("title",title);
        jsonObj.put("description",description);
        jsonObj.put("body",body);
        jsonObj.put("tagList",tagList);
        return jsonObj;
    }
}
