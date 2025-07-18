package conduitApp.utils;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class EncryptionUtils {

    //encoder
    public static String encrypt(String input){
        return Base64.getEncoder().encodeToString(input.getBytes(StandardCharsets.UTF_8));
    }

    //decoder
    public static String decrypt(String encodedInput){
        byte[] decodedBytes = Base64.getDecoder().decode(encodedInput);
        return new String(decodedBytes, StandardCharsets.UTF_8);
    }

    public static void main(String args[]){
        String encoded = encrypt("");
        System.out.println(encoded);
        //

        String decoded = decrypt("");
        System.out.println(decoded);
        //
    }
}


