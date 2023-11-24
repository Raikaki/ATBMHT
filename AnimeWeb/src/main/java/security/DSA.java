package security;

import java.io.FileInputStream;
import java.security.*;
import java.security.cert.Certificate;
import java.security.cert.CertificateFactory;
import java.util.Base64;
import javax.crypto.*;

public class DSA {

    public static KeyPair generateKeyPair() throws Exception {
        KeyPairGenerator keyGen = KeyPairGenerator.getInstance("DSA");
        keyGen.initialize(1024, new SecureRandom());
        KeyPair keyPair = keyGen.generateKeyPair();
        return keyPair;
    }

    public static byte[] signMessage(String message, PrivateKey privateKey) throws Exception {
        Signature signature = Signature.getInstance("SHA1withDSA");
        signature.initSign(privateKey);
        signature.update(message.getBytes());
        byte[] signatureBytes = signature.sign();
        return signatureBytes;
    }

    public static boolean verifyMessage(String message, PublicKey publicKey, byte[] signatureBytes) throws Exception {
        Signature signature = Signature.getInstance("SHA1withDSA");
        signature.initVerify(publicKey);
        signature.update(message.getBytes());
        boolean verified = signature.verify(signatureBytes);
        return verified;
    }

    public static String toBase64(byte[] bytes) {
        return Base64.getEncoder().encodeToString(bytes);
    }

    public static byte[] fromBase64(String base64) {
        return Base64.getDecoder().decode(base64);
    }
    public static Certificate getCertificate() throws Exception {
        CertificateFactory cf = CertificateFactory.getInstance("X.509");
        Certificate certificate = cf.generateCertificate(new FileInputStream("d:/file/ds/certificate.pem"));
        return certificate;
    }

    public static boolean verifyCertificate(Certificate certificate) throws Exception {

        CertificateFactory cf = CertificateFactory.getInstance("X.509");
        Certificate caCertificate = cf.generateCertificate(new FileInputStream("d:/file/ds/caCertificate.pem"));
        PublicKey caPublicKey = caCertificate.getPublicKey();
        certificate.verify(caPublicKey);
        return true;
    }
    public static void main(String[] args) throws Exception {

        KeyPair keyPair = generateKeyPair();
        PrivateKey privateKey = keyPair.getPrivate();
        PublicKey publicKey = keyPair.getPublic();


        String message = "This is a test message";
        byte[] signatureBytes = signMessage(message, privateKey);
        String signatureBase64 = toBase64(signatureBytes);
        System.out.println("Signature: " + signatureBase64);


        boolean verified = verifyMessage(message, publicKey, signatureBytes);
        System.out.println("Verified: " + verified);

        message = "This is a fake message";
        verified = verifyMessage(message, publicKey, signatureBytes);
        System.out.println("Verified: " + verified);
    }
}