import 'package:flutter/material.dart';

String buildPrivacyHtml(BuildContext context) {
  final code = Localizations.localeOf(context).languageCode;

  // English (default)
  String en() => '''
<h1>Voythrix Privacy Policy</h1>
<p><em>Last updated: September 11, 2025</em></p>

<div class='section'>
  <h2>Privacy-First Design</h2>
  <p>Voythrix is built with privacy as our fundamental principle. Your personal travel data never leaves your device. We do not operate servers that collect, store, or process your trip information. There is no automatic cloud synchronization, no user accounts, and no data transmission to external services.</p>
  
  <p>This privacy policy explains how Voythrix handles your data entirely on your device and what minimal information may be processed during your use of the app.</p>
</div>

<div class='section'>
  <h2>Information We Store Locally</h2>
  <p>All the following data is stored exclusively on your device in encrypted local databases and secure app directories:</p>
  
  <h3>Trip Information</h3>
  <ul>
    <li>Trip titles, destinations, dates, and descriptions</li>
    <li>Trip members and their details (names, emails)</li>
    <li>Default currencies and travel preferences</li>
    <li>Trip status and categorization</li>
  </ul>
  
  <h3>Itinerary Data</h3>
  <ul>
    <li>Daily activities, times, and locations</li>
    <li>Activity types and descriptions</li>
    <li>Custom notes and planning details</li>
  </ul>
  
  <h3>Tasks and Organization</h3>
  <ul>
    <li>To-do items, priorities, and due dates</li>
    <li>Task descriptions and completion status</li>
    <li>Custom categories and filters</li>
  </ul>
  
  <h3>Booking Information</h3>
  <ul>
    <li>Reservation details, confirmation numbers, and status</li>
    <li>Booking dates, times, and costs</li>
    <li>Attached files: confirmation emails, tickets, receipts, images</li>
    <li>Custom notes and reference information</li>
  </ul>
  
  <h3>Financial Data</h3>
  <ul>
    <li>Expense amounts, categories, and dates</li>
    <li>Advanced expense splitting configurations (equal and custom splits)</li>
    <li>Settlement calculations and payment tracking</li>
    <li>Individual expense settlement status</li>
    <li>Payment methods and splitting information</li>
    <li>Currency information and exchange notes</li>
    <li>Receipt attachments and descriptions</li>
  </ul>
  
  <h3>Personal Documents</h3>
  <ul>
    <li>Travel documents: passports, visas, insurance</li>
    <li>Document images, PDFs, and text files</li>
    <li>Document types, expiration dates, and notes</li>
    <li>Document metadata and organization tags</li>
  </ul>
  
  <h3>App Preferences</h3>
  <ul>
    <li>Language and localization settings</li>
    <li>Theme preferences (light/dark mode)</li>
    <li>Display options and user interface customizations</li>
    <li>App usage preferences and settings</li>
  </ul>
</div>

<div class='section'>
  <h2>Data Storage and Security</h2>
  <p><strong>Local Storage:</strong> All data is stored in the app's private, encrypted database on your device. File attachments are stored in the app's secure document directory, which is inaccessible to other applications.</p>
  
  <p><strong>Encryption:</strong> Your data is protected using industry-standard encryption methods. The local database uses SQLite with built-in encryption, and sensitive files are stored with additional security measures.</p>
  
  <p><strong>Access Control:</strong> Only Voythrix can access its own data directories. Other apps, including system apps, cannot read your travel information without explicit user action (such as when you choose to share or export data).</p>
  
  <p><strong>Data Isolation:</strong> Each installation of Voythrix maintains completely separate data. There is no cross-device synchronization or data sharing between installations.</p>
</div>

<div class='section'>
  <h2>Backup and Export</h2>
  <p><strong>User-Controlled Backups:</strong> You can create backup files (.voy format) that contain all your data. These backups are entirely under your control.</p>
  
  <p><strong>Encryption Options:</strong> If you set a password during backup creation, your backup is encrypted using AES-256 encryption with initialization vectors and integrity checksums. Unencrypted backups are compressed but not encrypted.</p>
  
  <p><strong>Password Recovery:</strong> We cannot recover lost backup passwords. If you forget a backup password, the encrypted backup cannot be restored. This is by design to ensure your data security.</p>
  
  <p><strong>Backup Contents:</strong> Backups include all trips, trip members, itineraries, tasks, bookings, expenses with settlement tracking, documents, and app settings. File attachments are included and maintain their original quality and metadata.</p>
</div>

<div class='section'>
  <h2>Device Permissions</h2>
  <p>Voythrix may request the following permissions to provide its features:</p>
  
  <ul>
    <li><strong>File System Access:</strong> To attach documents, images, and other files to bookings and personal documents. Also used for backup export and import operations.</li>
    <li><strong>Photo Library Access:</strong> To attach photos from your device's photo library and to save images when you choose to export them.</li>
    <li><strong>Camera Access:</strong> To capture photos directly for attachment to bookings or documents (if this feature is enabled).</li>
    <li><strong>Storage Access:</strong> To save backup files to your chosen location and to access files for import operations.</li>
  </ul>
  
  <p>These permissions are used exclusively for the features described and only when you actively use those features. No background access or data collection occurs.</p>
</div>

<div class='section'>
  <h2>Third-Party Services and Platform Integration</h2>
  <p><strong>Platform Services:</strong> Voythrix uses standard platform services provided by your device's operating system, including:</p>
  <ul>
    <li>File picker dialogs for selecting documents and attachments</li>
    <li>Share sheet functionality for exporting and sharing data</li>
    <li>URL handling for opening web links and email addresses</li>
    <li>Local notifications for reminders (if enabled)</li>
    <li>Platform-specific document viewers (PDF, image viewers)</li>
  </ul>
  
  <p>These services operate entirely on your device and do not transmit your personal data to external servers.</p>
  
  <p><strong>No Analytics or Tracking:</strong> Voythrix does not include any analytics, telemetry, crash reporting, or user tracking services. We do not collect usage statistics, behavioral data, or performance metrics.</p>
  
  <p><strong>No Advertising:</strong> Voythrix does not display advertisements and does not integrate with advertising networks or data brokers.</p>
</div>

<div class='section'>
  <h2>Data Sharing and Disclosure</h2>
  <p><strong>No Automatic Sharing:</strong> Voythrix never automatically shares your data with any third parties, including us (the developers). Your data remains on your device unless you explicitly choose to share it.</p>
  
  <p><strong>User-Initiated Sharing:</strong> You may choose to share specific information through:</p>
  <ul>
    <li>Exporting backup files that you can share with others</li>
    <li>Using your device's share functionality to send specific documents or information</li>
    <li>Manually copying and pasting information into other apps</li>
  </ul>
  
  <p><strong>Legal Requirements:</strong> Since your data is stored locally on your device and we have no access to it, we cannot be compelled to provide your personal information to law enforcement or other entities. Any such requests would need to be directed to you directly.</p>
</div>

<div class='section'>
  <h2>Data Retention and Deletion</h2>
  <p><strong>User Control:</strong> You have complete control over your data retention. Data remains on your device until you actively delete it.</p>
  
  <p><strong>Individual Deletion:</strong> You can delete individual items (trips, tasks, bookings, etc.) at any time through the app interface.</p>
  
  <p><strong>Complete Data Removal:</strong> Use the "Clear All Data" option in Settings to permanently remove all app data, including the database, attachments, and preferences. This action cannot be undone.</p>
  
  <p><strong>App Uninstallation:</strong> Uninstalling Voythrix removes all associated data from your device, including the app database and stored files.</p>
</div>

<div class='section'>
  <h2>Children's Privacy</h2>
  <p>Voythrix does not knowingly collect personal information from children under 13. Since all data is stored locally on the device and no information is transmitted to us, the app can be used by minors under appropriate parental supervision. Parents and guardians are responsible for monitoring their children's use of the app and the data they store within it.</p>
</div>

<div class='section'>
  <h2>International Users</h2>
  <p>Voythrix is designed to work globally without transmitting data across borders. Since all data is stored locally on your device, international data transfer regulations do not apply to the app's normal operation. When you create backups, you control where those files are stored and whether they cross international boundaries.</p>
</div>

<div class='section'>
  <h2>Changes to This Privacy Policy</h2>
  <p>We may update this privacy policy to reflect changes in the app's functionality or legal requirements. When we make changes, we will update the "Last updated" date at the top of this policy. Continued use of Voythrix after changes take effect constitutes acceptance of the updated policy.</p>
  
  <p>Since Voythrix operates offline, you may not receive automatic notifications of policy changes. We recommend reviewing this policy periodically when you access it through the app settings.</p>
</div>

<div class='section'>
  <h2>Your Rights and Choices</h2>
  <p>Since your data is stored locally on your device, you have complete control over it:</p>
  
  <ul>
    <li><strong>Access:</strong> You can view all your data at any time through the app interface</li>
    <li><strong>Correction:</strong> Edit any information directly within the app</li>
    <li><strong>Export:</strong> Create backup files containing all your data</li>
    <li><strong>Deletion:</strong> Remove individual items or all data as desired</li>
    <li><strong>Portability:</strong> Export your data in a standard format for use elsewhere</li>
  </ul>
  
  <p>These rights are built into the app's design and are available to you at all times without needing to contact us.</p>
</div>

<div class='section'>
  <h2>Contact Information</h2>
  <p>If you have questions about this privacy policy or Voythrix's privacy practices, please contact us at:</p>
  
  <p><strong>Email:</strong> <a href='mailto:voythrix@gmail.com'>voythrix@gmail.com</a><br/>
  <strong>Subject:</strong> Privacy Policy Question</p>
  
  <p>Please note that since we do not have access to your app data, we cannot help with data recovery, password recovery, or accessing specific information stored in your app. For technical support with app functionality, please use our general support contact.</p>
</div>

<div class='section'>
  <h2>Commitment to Privacy</h2>
  <p>Your privacy is not just a policy for us—it's a core design principle. Voythrix was built specifically to give you complete control over your travel data while providing powerful organizational tools. We believe that your personal information should remain personal, and our app's architecture ensures that belief is reflected in every aspect of its operation.</p>
</div>
''';

  // Spanish
  String es() => '''
<h1>Política de Privacidad de Voythrix</h1>
<p><em>Última actualización: 2025-09-11</em></p>

<div class='section'>
  <h2>Resumen</h2>
  <p>Voythrix está diseñado con la privacidad como prioridad. Tus datos se guardan localmente en tu dispositivo. No operamos servidores que reciban tus datos y no hay sincronización automática en la nube.</p>
</div>

<div class='section'>
  <h2>Datos que almacenamos</h2>
  <ul>
    <li>Viajes, tareas, reservas y gastos</li>
    <li>Documentos personales (p. ej., pasaporte) y archivos adjuntos de reservas</li>
    <li>Ajustes de la app (p. ej., tema, idioma)</li>
  </ul>
  <p>Todo lo anterior se almacena localmente en la base de datos y carpetas de documentos de la app en tu dispositivo.</p>
</div>

<div class='section'>
  <h2>Copias de seguridad</h2>
  <p>Puedes exportar copias de seguridad como archivos <code>.voy</code>. Si estableces una contraseña, la copia se cifra (AES‑256) y solo puede descifrarse con esa contraseña. No podemos recuperar contraseñas perdidas.</p>
</div>

<div class='section'>
  <h2>Permisos</h2>
  <p>La app puede solicitar permisos (p. ej., acceso a Fotos/Archivos) para adjuntar, ver o guardar archivos. Estos permisos se usan únicamente para esas funciones.</p>
</div>

<div class='section'>
  <h2>Servicios de terceros</h2>
  <p>Servicios básicos del dispositivo (p. ej., selectores de archivos, apertura de URLs) se ejecutan localmente para soportar funciones como ver PDFs o compartir archivos. No envían tus datos a servidores de Voythrix.</p>
</div>

<div class='section'>
  <h2>Control de datos</h2>
  <ul>
    <li><strong>Exportar</strong>: Crea copias de seguridad (con o sin cifrado) bajo tu control.</li>
    <li><strong>Importar</strong>: Restaura desde un archivo <code>.voy</code> válido.</li>
    <li><strong>Borrar todos los datos</strong>: Elimina permanentemente tus datos locales desde Ajustes.</li>
  </ul>
</div>

<div class='section'>
  <h2>Contacto</h2>
  <p>¿Preguntas sobre esta política? Escribe a <a href='mailto:voythrix@gmail.com'>voythrix@gmail.com</a>.</p>
</div>
''';

  // French
  String fr() => '''
<h1>Politique de Confidentialité Voythrix</h1>
<p><em>Dernière mise à jour : 2025-09-11</em></p>

<div class='section'>
  <h2>Aperçu</h2>
  <p>Voythrix est conçu avec la confidentialité en priorité. Vos données sont stockées localement sur votre appareil. Nous n'exploitons pas de serveurs recevant vos données et il n'y a pas de synchronisation cloud automatique.</p>
</div>

<div class='section'>
  <h2>Données que nous stockons</h2>
  <ul>
    <li>Voyages, tâches, réservations, dépenses</li>
    <li>Documents personnels (ex. passeport) et pièces jointes de réservations</li>
    <li>Paramètres de l’application (ex. thème, langue)</li>
  </ul>
  <p>Toutes ces données sont stockées localement dans la base de données de l’app et ses dossiers de documents sur votre appareil.</p>
</div>

<div class='section'>
  <h2>Sauvegardes</h2>
  <p>Vous pouvez exporter des sauvegardes au format <code>.voy</code>. Si vous définissez un mot de passe, la sauvegarde est chiffrée (AES‑256) et ne peut être déchiffrée qu’avec ce mot de passe. Nous ne pouvons pas récupérer un mot de passe perdu.</p>
</div>

<div class='section'>
  <h2>Autorisations</h2>
  <p>L’app peut demander des autorisations (ex. Photos/Fichiers) pour joindre, afficher ou enregistrer des fichiers. Ces autorisations sont utilisées uniquement pour ces fonctionnalités.</p>
</div>

<div class='section'>
  <h2>Services tiers</h2>
  <p>Des services locaux de la plateforme (ex. sélecteurs de fichiers, ouverture d’URL) s’exécutent sur votre appareil pour permettre l’affichage de PDF ou le partage de fichiers. Ils n’envoient pas vos données aux serveurs Voythrix.</p>
</div>

<div class='section'>
  <h2>Contrôle des données</h2>
  <ul>
    <li><strong>Exporter</strong> : créez des sauvegardes chiffrées ou non que vous contrôlez.</li>
    <li><strong>Importer</strong> : restaurez depuis un fichier <code>.voy</code> valide.</li>
    <li><strong>Tout effacer</strong> : supprimez définitivement vos données locales via les Réglages.</li>
  </ul>
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
