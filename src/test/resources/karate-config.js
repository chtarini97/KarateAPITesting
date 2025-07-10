function fn(){
    var env = karate.env; //get system property 'karate.env'
    karate.log('karate.env system property was:', env);

    if(!env){
        env = 'dev';
    }
    var config = {
        baseUrl: 'https://conduit-api.bondaracademy.com/api/'
    };
    if (env == 'dev') {
        config.userEmail = 'cinnamon@karate.testing';
        config.userPwd = 'karate.testing';
    }
    if (env == 'qa') {
        //customize
    }

    var accessToken = karate.callSingle('classpath:conduitApp/com/helpers/UserLogin.feature', config).authToken
    karate.configure('headers',{Authorization: 'Token '+ accessToken})

    return config;
}