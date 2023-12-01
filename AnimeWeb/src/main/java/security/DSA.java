package security;

import java.security.*;
import java.security.spec.InvalidKeySpecException;
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

    public byte[] signMessage(String data, PrivateKey privateKey) throws Exception {
        Signature signature = Signature.getInstance("SHA1withDSA");
        signature.initSign(privateKey);
        signature.update(data.getBytes());
        byte[] signatureBytes = signature.sign();
        return signatureBytes;
    }

    public boolean verifyMessage(String data, PublicKey publicKey, byte[] signatureBytes) throws Exception {
        Signature signature = Signature.getInstance("SHA1withDSA");
        signature.initVerify(publicKey);
        signature.update(data.getBytes());
        boolean verified = signature.verify(signatureBytes);
        return verified;
    }

    public String publicKeyToBase64() {
        return Base64.getEncoder().encodeToString(publicKey.getEncoded());
    }
    public String privateKeyToBase64() {
        return Base64.getEncoder().encodeToString(privateKey.getEncoded());
    }
//    public static Certificate getCertificate() throws Exception {
//        CertificateFactory cf = CertificateFactory.getInstance("X.509");
//        Certificate certificate = cf.generateCertificate(new FileInputStream("d:/file/ds/certificate.pem"));
//        return certificate;
//    }
//
//    public static boolean verifyCertificate(Certificate certificate) throws Exception {
//
//        CertificateFactory cf = CertificateFactory.getInstance("X.509");
//        Certificate caCertificate = cf.generateCertificate(new FileInputStream("d:/file/ds/caCertificate.pem"));
//        PublicKey caPublicKey = caCertificate.getPublicKey();
//        certificate.verify(caPublicKey);
//        return true;
//    }
public static boolean verifyPublicKey(String keyInput) throws NoSuchAlgorithmException, InvalidKeySpecException {
    if (keyInput.trim().equals(""))
        return false;
       byte[] publicKeyBytes = Base64.getDecoder().decode(keyInput);
       KeyFactory keyFactory = KeyFactory.getInstance("DSA");
       X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicKeyBytes);
       keyFactory.generatePublic(keySpec);
       return true;

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