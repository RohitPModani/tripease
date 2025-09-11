import 'package:flutter/material.dart';

String buildTermsHtml(BuildContext context) {
  final code = Localizations.localeOf(context).languageCode;

  String en() => '''
<h1>Voythrix Terms of Service</h1>
<p><em>Last updated: January 11, 2025</em></p>

<div class='section'>
  <h2>Acceptance of Terms</h2>
  <p>By downloading, installing, or using Voythrix, you agree to be bound by these Terms of Service ("Terms"). If you do not agree to these Terms, do not download, install, or use the app.</p>
  
  <p>These Terms constitute a legal agreement between you and the developers of Voythrix. By using the app, you represent that you are at least 13 years old and have the legal capacity to enter into this agreement.</p>
</div>

<div class='section'>
  <h2>Description of Service</h2>
  <p>Voythrix is a privacy-first, offline travel planning and organization application that allows you to:</p>
  <ul>
    <li>Create and manage travel itineraries with daily activities</li>
    <li>Organize trips with destinations, dates, and planning details</li>
    <li>Manage travel-related tasks and to-do lists</li>
    <li>Store booking information and confirmation documents</li>
    <li>Track travel expenses and categorize spending</li>
    <li>Store personal travel documents securely on your device</li>
    <li>Export and import data using encrypted backup files</li>
  </ul>
  
  <p>The app operates entirely offline and stores all data locally on your device. We do not provide cloud storage, synchronization services, or online account management.</p>
</div>

<div class='section'>
  <h2>Acceptable Use</h2>
  <p><strong>Permitted Use:</strong> Voythrix is intended for personal, non-commercial use for travel planning and organization. You may:</p>
  <ul>
    <li>Store your personal travel information, documents, and planning data</li>
    <li>Create backup files of your data for personal use</li>
    <li>Share specific travel information through the app's sharing features</li>
    <li>Use the app in connection with your personal or family travel</li>
  </ul>
  
  <p><strong>Prohibited Use:</strong> You may not:</p>
  <ul>
    <li>Use the app for any commercial, business, or revenue-generating purposes</li>
    <li>Store content that you do not own or have the right to store</li>
    <li>Store illegal, harmful, or inappropriate content</li>
    <li>Store content that violates intellectual property rights</li>
    <li>Attempt to reverse engineer, modify, or create derivative works of the app</li>
    <li>Use the app to store malware, viruses, or harmful code</li>
    <li>Circumvent any security features or access restrictions</li>
  </ul>
</div>

<div class='section'>
  <h2>Your Content and Responsibilities</h2>
  <p><strong>Content Ownership:</strong> You retain ownership of all content you store in Voythrix, including travel documents, photos, booking information, and personal data.</p>
  
  <p><strong>Content Responsibility:</strong> You are solely responsible for:</p>
  <ul>
    <li>The accuracy and legality of all content you store in the app</li>
    <li>Ensuring you have the right to store and use any documents or images</li>
    <li>Maintaining the security of sensitive documents and information</li>
    <li>Complying with applicable laws regarding document storage and data protection</li>
    <li>Creating and maintaining backups of important data</li>
  </ul>
  
  <p><strong>Sensitive Information:</strong> While Voythrix is designed to securely store travel documents and personal information, you should exercise caution when storing highly sensitive data such as passport scans, financial information, or confidential documents.</p>
</div>

<div class='section'>
  <h2>Data and Backup Management</h2>
  <p><strong>Local Storage:</strong> All your data is stored locally on your device. You understand and agree that:</p>
  <ul>
    <li>We do not have access to your stored data</li>
    <li>We cannot recover lost data from your device</li>
    <li>Data may be lost if your device is damaged, lost, or reset</li>
    <li>App uninstallation will permanently delete all stored data</li>
  </ul>
  
  <p><strong>Backup Responsibility:</strong> You are responsible for creating and managing backups of your data. Voythrix provides backup and restore functionality, but:</p>
  <ul>
    <li>You must initiate backup creation manually</li>
    <li>You are responsible for securely storing backup files</li>
    <li>We cannot recover forgotten backup passwords</li>
    <li>Backup file integrity depends on proper storage and handling</li>
  </ul>
  
  <p><strong>Data Loss:</strong> We are not liable for any data loss, regardless of cause, including but not limited to device malfunction, app updates, operating system changes, or user error.</p>
</div>

<div class='section'>
  <h2>Privacy and Security</h2>
  <p>Your privacy is important to us. Please review our Privacy Policy, which explains how we handle your information and your privacy rights. By using Voythrix, you agree to the collection and use of information as outlined in our Privacy Policy.</p>
  
  <p><strong>Security Measures:</strong> While we implement security measures to protect your data within the app, you acknowledge that:</p>
  <ul>
    <li>No system is completely secure</li>
    <li>You are responsible for device-level security (passcodes, biometric locks, etc.)</li>
    <li>Backup encryption security depends on your password strength</li>
    <li>Physical device security is your responsibility</li>
  </ul>
</div>

<div class='section'>
  <h2>Intellectual Property</h2>
  <p><strong>App Ownership:</strong> Voythrix, including its design, code, graphics, and functionality, is owned by its developers and protected by intellectual property laws. You are granted a limited, non-exclusive, non-transferable license to use the app solely for its intended purpose.</p>
  
  <p><strong>Restrictions:</strong> You may not:</p>
  <ul>
    <li>Copy, modify, or distribute the app or its components</li>
    <li>Reverse engineer or attempt to extract source code</li>
    <li>Create derivative works based on the app</li>
    <li>Remove or modify copyright notices or branding</li>
    <li>Use the app's name or branding for your own purposes</li>
  </ul>
  
  <p><strong>Third-Party Content:</strong> The app may include third-party components or libraries. Such components are subject to their respective licenses and terms.</p>
</div>

<div class='section'>
  <h2>App Updates and Changes</h2>
  <p><strong>Updates:</strong> We may release updates to improve functionality, fix bugs, or enhance security. While updates are generally backward-compatible, we cannot guarantee compatibility with all versions or devices.</p>
  
  <p><strong>Feature Changes:</strong> We reserve the right to modify, suspend, or discontinue any features of Voythrix at any time. We will make reasonable efforts to maintain compatibility and provide migration paths for your data.</p>
  
  <p><strong>Support:</strong> We provide support on a best-effort basis but do not guarantee continuous availability or specific response times.</p>
</div>

<div class='section'>
  <h2>Device Compatibility and Requirements</h2>
  <p><strong>System Requirements:</strong> Voythrix requires compatible hardware and software to function properly. We do not guarantee compatibility with all devices or operating system versions.</p>
  
  <p><strong>Performance:</strong> App performance may vary based on device capabilities, available storage, and the amount of data stored. Large amounts of data or attachments may affect performance.</p>
  
  <p><strong>Storage Limitations:</strong> Your device's available storage limits how much data you can store in Voythrix. You are responsible for managing storage space and data organization.</p>
</div>

<div class='section'>
  <h2>Disclaimers and Warranties</h2>
  <p><strong>No Warranties:</strong> Voythrix is provided "AS IS" and "AS AVAILABLE" without warranties of any kind, either express or implied, including but not limited to:</p>
  <ul>
    <li>Warranties of merchantability or fitness for a particular purpose</li>
    <li>Warranties of accuracy, reliability, or completeness</li>
    <li>Warranties of uninterrupted or error-free operation</li>
    <li>Warranties regarding data integrity or security</li>
  </ul>
  
  <p><strong>Travel Disclaimer:</strong> Voythrix is a planning tool only. We do not:</p>
  <ul>
    <li>Provide travel advice, recommendations, or booking services</li>
    <li>Verify the accuracy of travel information you enter</li>
    <li>Guarantee the validity of travel documents or bookings</li>
    <li>Take responsibility for travel decisions based on app data</li>
  </ul>
  
  <p><strong>Third-Party Services:</strong> Any integration with third-party services (such as system file pickers or sharing functions) is provided as-is and subject to those services' terms and availability.</p>
</div>

<div class='section'>
  <h2>Limitation of Liability</h2>
  <p><strong>Liability Limits:</strong> To the maximum extent permitted by applicable law, we shall not be liable for any indirect, incidental, special, consequential, or punitive damages, including but not limited to:</p>
  <ul>
    <li>Loss of data, profits, or business opportunities</li>
    <li>Travel disruptions or missed connections</li>
    <li>Costs of substitute services or applications</li>
    <li>Damages arising from device malfunction or data corruption</li>
    <li>Any damages exceeding the amount paid for the app (if any)</li>
  </ul>
  
  <p><strong>Force Majeure:</strong> We are not liable for any failure to perform due to circumstances beyond our reasonable control, including natural disasters, government actions, or technical failures of third-party services.</p>
  
  <p><strong>User Responsibility:</strong> You acknowledge that travel planning involves inherent risks and that you are solely responsible for verifying travel information, maintaining valid documents, and making informed travel decisions.</p>
</div>

<div class='section'>
  <h2>Indemnification</h2>
  <p>You agree to indemnify, defend, and hold harmless the developers of Voythrix from and against any claims, damages, losses, costs, or expenses (including reasonable attorney fees) arising from:</p>
  <ul>
    <li>Your use of the app in violation of these Terms</li>
    <li>Your storage of illegal, infringing, or harmful content</li>
    <li>Your violation of any third-party rights</li>
    <li>Any travel decisions or actions based on information stored in the app</li>
  </ul>
</div>

<div class='section'>
  <h2>Termination</h2>
  <p><strong>Termination by You:</strong> You may stop using Voythrix at any time by uninstalling the app from your device. Uninstallation will permanently delete all stored data.</p>
  
  <p><strong>Effect of Termination:</strong> Upon termination:</p>
  <ul>
    <li>Your license to use Voythrix immediately ends</li>
    <li>All local data will be deleted upon app uninstallation</li>
    <li>Backup files you have created remain under your control</li>
    <li>These Terms remain in effect regarding your past use of the app</li>
  </ul>
</div>

<div class='section'>
  <h2>Geographic Restrictions</h2>
  <p>Voythrix is intended for use worldwide, but we do not represent that all features will be available or legal in all jurisdictions. You are responsible for compliance with local laws regarding:</p>
  <ul>
    <li>Data storage and privacy regulations</li>
    <li>Document imaging and storage laws</li>
    <li>Cross-border data transfer requirements</li>
    <li>Financial record-keeping obligations</li>
  </ul>
</div>

<div class='section'>
  <h2>Changes to These Terms</h2>
  <p><strong>Updates:</strong> We may update these Terms to reflect changes in the app, legal requirements, or business practices. When we make material changes, we will update the "Last updated" date at the top of these Terms.</p>
  
  <p><strong>Notification:</strong> Since Voythrix operates offline, you may not receive automatic notifications of Terms changes. We recommend reviewing these Terms periodically through the app settings.</p>
  
  <p><strong>Acceptance:</strong> Continued use of Voythrix after Terms changes take effect constitutes acceptance of the updated Terms. If you do not agree to updated Terms, you should stop using the app.</p>
</div>

<div class='section'>
  <h2>Dispute Resolution</h2>
  <p><strong>Informal Resolution:</strong> Before pursuing formal legal action, please contact us at voythrix@gmail.com to attempt to resolve any disputes informally.</p>
  
  <p><strong>Governing Law:</strong> These Terms are governed by and construed in accordance with applicable law. Any disputes will be resolved in courts of competent jurisdiction.</p>
  
  <p><strong>Severability:</strong> If any provision of these Terms is found to be unenforceable, the remaining provisions will continue in full force and effect.</p>
</div>

<div class='section'>
  <h2>Entire Agreement</h2>
  <p>These Terms, together with our Privacy Policy, constitute the entire agreement between you and us regarding Voythrix and supersede all prior agreements and understandings.</p>
</div>

<div class='section'>
  <h2>Contact Information</h2>
  <p>If you have questions about these Terms of Service, please contact us:</p>
  
  <p><strong>Email:</strong> <a href='mailto:voythrix@gmail.com'>voythrix@gmail.com</a><br/>
  <strong>Subject:</strong> Terms of Service Question</p>
  
  <p>For technical support or general inquiries, please use our standard support contact information available in the app's Help section.</p>
</div>

<div class='section'>
  <h2>Acknowledgment</h2>
  <p>By using Voythrix, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service and our Privacy Policy. You also acknowledge that these Terms may be updated from time to time and that your continued use of the app constitutes acceptance of any changes.</p>
</div>
''';

  String es() => '''
<h1>Términos de Servicio de Voythrix</h1>
<p><em>Última actualización: 2025-09-11</em></p>

<div class='section'>
  <h2>Acuerdo</h2>
  <p>Al usar Voythrix, aceptas estos Términos. Si no estás de acuerdo, no utilices la app.</p>
</div>

<div class='section'>
  <h2>Uso de la App</h2>
  <ul>
    <li>Eres responsable del contenido que agregas (documentos, reservas, gastos).</li>
    <li>No subas contenido que no tengas derecho a almacenar en tu dispositivo.</li>
    <li>Voythrix se ofrece para la planificación y organización personal de viajes.</li>
  </ul>
</div>

<div class='section'>
  <h2>Copias de seguridad y seguridad</h2>
  <p>Puedes exportar copias de seguridad cifradas con una contraseña. Mantén la contraseña segura; no podemos recuperar copias cifradas sin ella.</p>
</div>

<div class='section'>
  <h2>Privacidad</h2>
  <p>Consulta nuestra Política de Privacidad para saber cómo se manejan tus datos localmente en tu dispositivo.</p>
</div>

<div class='section'>
  <h2>Descargo de responsabilidad</h2>
  <p>Voythrix se proporciona “tal cual”, sin garantías de ningún tipo. No somos responsables por pérdidas de datos en tu dispositivo ni por problemas derivados de archivos dañados o mal formados.</p>
</div>

<div class='section'>
  <h2>Limitación de responsabilidad</h2>
  <p>En la máxima medida permitida por la ley, Voythrix no será responsable por daños indirectos, incidentales, especiales, consecuentes o punitivos, ni por pérdidas de datos, derivados del uso de la app.</p>
</div>

<div class='section'>
  <h2>Cambios en los Términos</h2>
  <p>Podemos actualizar estos Términos de vez en cuando. Seguir usando la app después de la entrada en vigor de los cambios constituye la aceptación de los Términos revisados.</p>
</div>

<div class='section'>
  <h2>Contacto</h2>
  <p>¿Preguntas sobre estos Términos? Escribe a <a href='mailto:voythrix@gmail.com'>voythrix@gmail.com</a>.</p>
</div>
''';

  String fr() => '''
<h1>Conditions d’Utilisation de Voythrix</h1>
<p><em>Dernière mise à jour : 2025-09-11</em></p>

<div class='section'>
  <h2>Accord</h2>
  <p>En utilisant Voythrix, vous acceptez ces Conditions. Si vous n’êtes pas d’accord, n’utilisez pas l’app.</p>
</div>

<div class='section'>
  <h2>Utilisation de l’App</h2>
  <ul>
    <li>Vous êtes responsable du contenu que vous ajoutez (documents, réservations, dépenses).</li>
    <li>N’ajoutez pas de contenu dont vous n’avez pas le droit de stocker sur votre appareil.</li>
    <li>Voythrix est fourni pour l’organisation et la planification personnelles de voyages.</li>
  </ul>
</div>

<div class='section'>
  <h2>Sauvegardes & sécurité</h2>
  <p>Vous pouvez exporter des sauvegardes chiffrées avec un mot de passe. Conservez‑le en sécurité ; nous ne pouvons pas récupérer les sauvegardes chiffrées sans celui‑ci.</p>
</div>

<div class='section'>
  <h2>Confidentialité</h2>
  <p>Consultez notre Politique de Confidentialité pour comprendre la gestion locale de vos données sur votre appareil.</p>
</div>

<div class='section'>
  <h2>Avertissement</h2>
  <p>Voythrix est fourni « en l’état » sans aucune garantie. Nous ne sommes pas responsables des pertes de données sur votre appareil ni des problèmes liés à des fichiers corrompus ou mal formés.</p>
</div>

<div class='section'>
  <h2>Limitation de responsabilité</h2>
  <p>Dans la limite autorisée par la loi, Voythrix ne peut être tenu responsable des dommages indirects, spéciaux, consécutifs ou punitifs, ni de toute perte de données, résultant de votre utilisation de l’app.</p>
</div>

<div class='section'>
  <h2>Modifications des Conditions</h2>
  <p>Nous pouvons mettre à jour ces Conditions périodiquement. L’utilisation continue de l’app après l’entrée en vigueur des changements vaut acceptation des Conditions révisées.</p>
</div>

<div class='section'>
  <h2>Contact</h2>
  <p>Des questions ? Écrivez‑nous à <a href='mailto:voythrix@gmail.com'>voythrix@gmail.com</a>.</p>
</div>
''';

  switch (code) {
    case 'es':
      return es();
    case 'fr':
      return fr();
    default:
      return en();
  }
}
