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
    public static PrivateKey verifyPrivateKey(String keyInput) throws Exception {
        if (keyInput.trim().equals(""))
            return null;
        byte[] privateKeyBytes = Base64.getDecoder().decode(keyInput);
        KeyFactory keyFactory = KeyFactory.getInstance("DSA");
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateKeyBytes);
        return keyFactory.generatePrivate(keySpec);
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

        DSA dsa = new DSA();
        dsa.generateKey();
        System.out.println(dsa.privateKeyToBase64());
//        System.out.println(dsa.publicKeyToBase64());
//        verifyPublicKey("MIIDQjCCAjUGByqGSM44BAEwggIoAoIBAQCPeTXZuarpv6vtiHrPSVG28y7FnjuvNxjo6sSWHz79NgbnQ1GpxBgzObgJ58KuHFObp0dbhdARrbi0eYd1SYRpXKwOjxSzNggooi/6JxEKPWKpk0U0CaD+aWxGWPhL3SCBnDcJoBBXsZWtzQAjPbpUhLYpH51kjviDRIZ3l5zsBLQ0pqwudemYXeI9sCkvwRGMn/qdgYHnM423krcw17njSVkvaAmYchU5Feo9a4tGU8YzRY+AOzKkwuDycpAlbk4/ijsIOKHEUOThjBopo33fXqFD3ktm/wSQPtXPFiPhWNSHxgjpfyEc2B3KI8tuOAdl+CLjQr5ITAV2OTlgHNZnAh0AuvaWpoV499/e5/pnyXfHhe8ysjO65YDAvNVpXQKCAQAWplxYIEhQcE51AqOXVwQNNNo6NHjBVNTkpcAtJC7gT5bmHkvQkEq9rI837rHgnzGC0jyQQ8tkL4gAQWDt+coJsyB2p5wypifyRz6Rh5uixOdEvSCBVEy1W4AsNo0fqD7UielOD6BojjJCilx4xHjGjQUntxyaOrsLC+EsRGiWOefTznTbEBplqiuH9kxoJts+xy9LVZmDS7TtsC98kOmkltOlXVNb6/xF1PYZ9j897buHOSXC8iTgdzEpbaiH7B5HSPh++1/et1SEMWsiMt7lU92vAhErDR8C2jCXMiT+J67ai51LKSLZuovjntnhA6Y8UoELxoi34u1DFuHvF9veA4IBBQACggEAYUvlSJoYZwJv31y7pU+oDcZm5QVtiySGXTclcokv30wP1r/ED6lX814d0hy74Xw2gAloFeAltCynRfsUqkE5ZpTwku8uNERv3xCT/j3MEJKaOpOVqFCW2GLbXxG1XKuTfXO09TvCfXX+iiaF70F7NOMC922RBQ/3DhM3luzgulCI0g/Y3EZPfjAagV+eJH+QD4cLrHE5ENTwtGvl8oYl0YVYHK1wRgtDfeJAJK3qJG7dTv2lO4gKodULRNzYRAvL7pFxX9xfrzGj79YpW5QFfyzVFtbZiAoIAAMrO/b6AHwC0EYIDTIyPHdv0vMr5vfeggcdnjzZ9hROwnhxwrv8SA==");
//
        verifyPrivateKey("MIICXAIBADCCAjUGByqGSM44BAEwggIoAoIBAQCPeTXZuarpv6vtiHrPSVG28y7FnjuvNxjo6sSWHz79NgbnQ1GpxBgzObgJ58KuHFObp0dbhdARrbi0eYd1SYRpXKwOjxSzNggooi/6JxEKPWKpk0U0CaD+aWxGWPhL3SCBnDcJoBBXsZWtzQAjPbpUhLYpH51kjviDRIZ3l5zsBLQ0pqwudemYXeI9sCkvwRGMn/qdgYHnM423krcw17njSVkvaAmYchU5Feo9a4tGU8YzRY+AOzKkwuDycpAlbk4/ijsIOKHEUOThjBopo33fXqFD3ktm/wSQPtXPFiPhWNSHxgjpfyEc2B3KI8tuOAdl+CLjQr5ITAV2OTlgHNZnAh0AuvaWpoV499/e5/pnyXfHhe8ysjO65YDAvNVpXQKCAQAWplxYIEhQcE51AqOXVwQNNNo6NHjBVNTkpcAtJC7gT5bmHkvQkEq9rI837rHgnzGC0jyQQ8tkL4gAQWDt+coJsyB2p5wypifyRz6Rh5uixOdEvSCBVEy1W4AsNo0fqD7UielOD6BojjJCilx4xHjGjQUntxyaOrsLC+EsRGiWOefTznTbEBplqiuH9kxoJts+xy9LVZmDS7TtsC98kOmkltOlXVNb6/xF1PYZ9j897buHOSXC8iTgdzEpbaiH7B5HSPh++1/et1SEMWsiMt7lU92vAhErDR8C2jCXMiT+J67ai51LKSLZuovjntnhA6Y8UoELxoi34u1DFuHvF9veBB4CHH084AJ38jI6lkNWrcIFGJWtMW42+z4MNLkvOng=");
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