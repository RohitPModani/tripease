import 'package:flutter/material.dart';

String buildPrivacyHtml(BuildContext context) {
  final code = Localizations.localeOf(context).languageCode;

  // English (default)
  String en() => '''
<h1>Voythrix Privacy Policy</h1>
<p><em>Last updated: 2025-09-11</em></p>

<div class=\"section\">
  <h2>Overview</h2>
  <p>Voythrix is designed to be privacy‑first. Your data is stored locally on your device. We do not run servers that receive your trip data, and there is no automatic cloud sync.</p>
</div>

<div class=\"section\">
  <h2>Data We Store</h2>
  <ul>
    <li>Trips, To‑Dos, Bookings, Expenses</li>
    <li>Personal Documents (e.g., passport scans) and Booking Attachments</li>
    <li>App settings (e.g., theme, language)</li>
  </ul>
  <p>All of the above is stored locally in the app’s database and app document folders on your device.</p>
</div>

<div class=\"section\">
  <h2>Backups</h2>
  <p>You can export backups as <code>.voy</code> files. If you set a password, the backup is encrypted (AES‑256) and can only be decrypted with that password. We cannot recover a lost password.</p>
</div>

<div class=\"section\">
  <h2>Permissions</h2>
  <p>The app may request permissions (e.g., Photos/Files access) to attach, view, or save files. These permissions are used solely for the indicated features.</p>
</div>

<div class=\"section\">
  <h2>Third‑Party Services</h2>
  <p>Basic platform services (e.g., file pickers, URL handlers) run on your device to support features like viewing PDFs or sharing files. They do not send your data to Voythrix servers.</p>
</div>

<div class=\"section\">
  <h2>Data Control</h2>
  <ul>
    <li><strong>Export</strong>: Create encrypted or unencrypted backups you control.</li>
    <li><strong>Import</strong>: Restore from a valid <code>.voy</code> backup.</li>
    <li><strong>Clear All Data</strong>: Permanently delete your in‑app data from the local database and preferences via Settings.</li>
  </ul>
</div>

<div class=\"section\">
  <h2>Contact</h2>
  <p>Questions about this policy? Email <a href=\"mailto:voythrix@gmail.com\">voythrix@gmail.com</a>.</p>
</div>
''';

  // Spanish
  String es() => '''
<h1>Política de Privacidad de Voythrix</h1>
<p><em>Última actualización: 2025-09-11</em></p>

<div class=\"section\">
  <h2>Resumen</h2>
  <p>Voythrix está diseñado con la privacidad como prioridad. Tus datos se guardan localmente en tu dispositivo. No operamos servidores que reciban tus datos y no hay sincronización automática en la nube.</p>
</div>

<div class=\"section\">
  <h2>Datos que almacenamos</h2>
  <ul>
    <li>Viajes, tareas, reservas y gastos</li>
    <li>Documentos personales (p. ej., pasaporte) y archivos adjuntos de reservas</li>
    <li>Ajustes de la app (p. ej., tema, idioma)</li>
  </ul>
  <p>Todo lo anterior se almacena localmente en la base de datos y carpetas de documentos de la app en tu dispositivo.</p>
</div>

<div class=\"section\">
  <h2>Copias de seguridad</h2>
  <p>Puedes exportar copias de seguridad como archivos <code>.voy</code>. Si estableces una contraseña, la copia se cifra (AES‑256) y solo puede descifrarse con esa contraseña. No podemos recuperar contraseñas perdidas.</p>
</div>

<div class=\"section\">
  <h2>Permisos</h2>
  <p>La app puede solicitar permisos (p. ej., acceso a Fotos/Archivos) para adjuntar, ver o guardar archivos. Estos permisos se usan únicamente para esas funciones.</p>
</div>

<div class=\"section\">
  <h2>Servicios de terceros</h2>
  <p>Servicios básicos del dispositivo (p. ej., selectores de archivos, apertura de URLs) se ejecutan localmente para soportar funciones como ver PDFs o compartir archivos. No envían tus datos a servidores de Voythrix.</p>
</div>

<div class=\"section\">
  <h2>Control de datos</h2>
  <ul>
    <li><strong>Exportar</strong>: Crea copias de seguridad (con o sin cifrado) bajo tu control.</li>
    <li><strong>Importar</strong>: Restaura desde un archivo <code>.voy</code> válido.</li>
    <li><strong>Borrar todos los datos</strong>: Elimina permanentemente tus datos locales desde Ajustes.</li>
  </ul>
</div>

<div class=\"section\">
  <h2>Contacto</h2>
  <p>¿Preguntas sobre esta política? Escribe a <a href=\"mailto:voythrix@gmail.com\">voythrix@gmail.com</a>.</p>
</div>
''';

  // French
  String fr() => '''
<h1>Politique de Confidentialité Voythrix</h1>
<p><em>Dernière mise à jour : 2025-09-11</em></p>

<div class=\"section\">
  <h2>Aperçu</h2>
  <p>Voythrix est conçu avec la confidentialité en priorité. Vos données sont stockées localement sur votre appareil. Nous n’exploitons pas de serveurs recevant vos données et il n’y a pas de synchronisation cloud automatique.</p>
</div>

<div class=\"section\">
  <h2>Données que nous stockons</h2>
  <ul>
    <li>Voyages, tâches, réservations, dépenses</li>
    <li>Documents personnels (ex. passeport) et pièces jointes de réservations</li>
    <li>Paramètres de l’application (ex. thème, langue)</li>
  </ul>
  <p>Toutes ces données sont stockées localement dans la base de données de l’app et ses dossiers de documents sur votre appareil.</p>
</div>

<div class=\"section\">
  <h2>Sauvegardes</h2>
  <p>Vous pouvez exporter des sauvegardes au format <code>.voy</code>. Si vous définissez un mot de passe, la sauvegarde est chiffrée (AES‑256) et ne peut être déchiffrée qu’avec ce mot de passe. Nous ne pouvons pas récupérer un mot de passe perdu.</p>
</div>

<div class=\"section\">
  <h2>Autorisations</h2>
  <p>L’app peut demander des autorisations (ex. Photos/Fichiers) pour joindre, afficher ou enregistrer des fichiers. Ces autorisations sont utilisées uniquement pour ces fonctionnalités.</p>
</div>

<div class=\"section\">
  <h2>Services tiers</h2>
  <p>Des services locaux de la plateforme (ex. sélecteurs de fichiers, ouverture d’URL) s’exécutent sur votre appareil pour permettre l’affichage de PDF ou le partage de fichiers. Ils n’envoient pas vos données aux serveurs Voythrix.</p>
</div>

<div class=\"section\">
  <h2>Contrôle des données</h2>
  <ul>
    <li><strong>Exporter</strong> : créez des sauvegardes chiffrées ou non que vous contrôlez.</li>
    <li><strong>Importer</strong> : restaurez depuis un fichier <code>.voy</code> valide.</li>
    <li><strong>Tout effacer</strong> : supprimez définitivement vos données locales via les Réglages.</li>
  </ul>
</div>

<div class=\"section\">
  <h2>Contact</h2>
  <p>Des questions ? Écrivez‑nous à <a href=\"mailto:voythrix@gmail.com\">voythrix@gmail.com</a>.</p>
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
