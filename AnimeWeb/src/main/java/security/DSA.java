package security;

import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
public class DSA {
    private PublicKey publicKey;
    private PrivateKey privateKey;
    public void generateKey() throws Exception {
        KeyPairGenerator keyGen = KeyPairGenerator.getInstance("DSA");
        keyGen.initialize(2048, new SecureRandom());
        KeyPair keyPair = keyGen.generateKeyPair();
        publicKey = keyPair.getPublic();
        privateKey = keyPair.getPrivate();

    }

    public static byte[] signBill(String data, PrivateKey privateKey) throws Exception {
        Signature signature = Signature.getInstance("SHA256withDSA");
        signature.initSign(privateKey);
        signature.update(data.getBytes());
        byte[] signatureBytes = signature.sign();
        return signatureBytes;
    }

    public static boolean verifyBill(String data, PublicKey publicKey, String signatureData) throws Exception {
        Signature signature = Signature.getInstance("SHA256withDSA");
        signature.initVerify(publicKey);
        signature.update(data.getBytes());
        byte[] signatureBytes = Base64.getDecoder().decode(signatureData);
        return signature.verify(signatureBytes);
    }

    public  String publicKeyToBase64() {
        return Base64.getEncoder().encodeToString(publicKey.getEncoded());
    }
    public String privateKeyToBase64() {
        return Base64.getEncoder().encodeToString(privateKey.getEncoded());
    }
    public static PublicKey verifyPublicKey(String keyInput) throws NoSuchAlgorithmException, InvalidKeySpecException {
    if (keyInput.trim().equals(""))
        return null;
       byte[] publicKeyBytes = Base64.getDecoder().decode(keyInput);
       KeyFactory keyFactory = KeyFactory.getInstance("DSA");
       X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicKeyBytes);

       return keyFactory.generatePublic(keySpec);

}
    public static PrivateKey verifyPrivateKey(String keyInput) {
        if (keyInput.trim().equals(""))
            return null;

        try {
            byte[] privateKeyBytes = Base64.getDecoder().decode(keyInput);
            KeyFactory keyFactory = KeyFactory.getInstance("DSA");
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateKeyBytes);
            return keyFactory.generatePrivate(keySpec);
        } catch (Exception e) {
            e.printStackTrace(); // Log or handle the exception appropriately
            return null;
        }
    }
    public PublicKey getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(PublicKey publicKey) {
        this.publicKey = publicKey;
    }

    public PrivateKey getPrivateKey() {
        return privateKey;
    }

    public void setPrivateKey(PrivateKey privateKey) {
        this.privateKey = privateKey;
    }
    public static String toBase64(byte[] bytes){
        return Base64.getEncoder().encodeToString(bytes);
    }

    public static void main(String[] args) throws Exception {

//
//        KeyPair keyPair = generateKeyPair();
//        PrivateKey privateKey = keyPair.getPrivate();
//        PublicKey publicKey = keyPair.getPublic();
//        System.out.println(toBase64(publicKey.getEncoded()));


//
//
//        String message = "This is a test message";
//        byte[] signatureBytes = signMessage(message, privateKey);
//        String signatureBase64 = toBase64(signatureBytes);
//        System.out.println("Signature: " + signatureBase64);
//
//
//        boolean verified = verifyMessage(message, publicKey, signatureBytes);
//        System.out.println("Verified: " + verified);
//
//        message = "This is a fake message";
//        verified = verifyMessage(message, publicKey, signatureBytes);
//        System.out.println("Verified: " + verified);
    }
}