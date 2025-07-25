function fn(){
    var env = karate.env; //get system property 'karate.env'
    karate.log('karate.env system property was:', env);

    if(!env){
        env = 'dev';
    }

    var encryptionUtils = Java.type('conduitApp.utils.EncryptionUtils');

    var config = {
        baseUrl: 'https://conduit-api.bondaracademy.com/api/'
    };
    if (env == 'dev') {
        config.userEmail = 'cinnamon@karate.testing';
        config.userName = 'Cinnamon'
        config.encodedPwd = "a2FyYXRlLnRlc3Rpbmc=";
        config.userPwd = encryptionUtils.decrypt(config.encodedPwd);
    }
    if (env == 'qa') {
        //customize
    }

    var accessToken = karate.callSingle('classpath:conduitApp/helpers/CreateToken.feature', config).authToken
    karate.configure('headers',{Authorization: 'Token '+ accessToken})

    return config;
}