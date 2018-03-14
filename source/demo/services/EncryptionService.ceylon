shared interface EncryptionService {
    shared formal Boolean checkPassword(String plainPassword, String encryptedPassword);
    
    shared formal String encryptPassword(String plainPassword);
}
