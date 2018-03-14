import demo.services {
    EncryptionService
}

import org.jasypt.util.password {
    StrongPasswordEncryptor
}
import org.springframework.beans.factory.annotation {
    autowired
}
import org.springframework.stereotype {
    service
}

service
class EncryptionServiceImpl() satisfies EncryptionService {
    autowired
    shared late StrongPasswordEncryptor strongPasswordEncryptor;
    
    checkPassword(String plainPassword, String encryptedPassword)
            => strongPasswordEncryptor.checkPassword(plainPassword, encryptedPassword);
    
    encryptPassword(String plainPassword)
            => strongPasswordEncryptor.encryptPassword(plainPassword);
}
