import 'package:flutter/material.dart';

String buildTermsHtml(BuildContext context) {
  final code = Localizations.localeOf(context).languageCode;

  String en() => '''
<h1>Voythrix Terms of Service</h1>
<p><em>Last updated: 2025-09-11</em></p>

<div class=\"section\">
  <h2>Agreement</h2>
  <p>By using Voythrix, you agree to these Terms. If you do not agree, do not use the app.</p>
</div>

<div class=\"section\">
  <h2>Use of the App</h2>
  <ul>
    <li>You are responsible for the content you add (e.g., documents, bookings, expenses).</li>
    <li>Do not upload content you do not have rights to store on your device.</li>
    <li>Voythrix is provided for personal trip planning and organization.</li>
  </ul>
</div>

<div class=\"section\">
  <h2>Backups & Security</h2>
  <p>You can export encrypted backups using a password you set. Keep your password secure; encrypted backups cannot be recovered without it.</p>
</div>

<div class=\"section\">
  <h2>Privacy</h2>
  <p>See our Privacy Policy for details on how your data is handled locally on your device.</p>
</div>

<div class=\"section\">
  <h2>Disclaimer</h2>
  <p>Voythrix is provided “as is” without warranties of any kind. We are not responsible for loss of data on your device or for issues arising from malformed or corrupted files.</p>
</div>

<div class=\"section\">
  <h2>Limitation of Liability</h2>
  <p>To the maximum extent permitted by law, Voythrix shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of data, arising from your use of the app.</p>
</div>

<div class=\"section\">
  <h2>Changes to Terms</h2>
  <p>We may update these Terms from time to time. Continued use of the app after changes take effect constitutes acceptance of the revised Terms.</p>
</div>

<div class=\"section\">
  <h2>Contact</h2>
  <p>Questions about these Terms? Email <a href=\"mailto:voythrix@gmail.com\">voythrix@gmail.com</a>.</p>
</div>
''';

  String es() => '''
<h1>Términos de Servicio de Voythrix</h1>
<p><em>Última actualización: 2025-09-11</em></p>

<div class=\"section\">
  <h2>Acuerdo</h2>
  <p>Al usar Voythrix, aceptas estos Términos. Si no estás de acuerdo, no utilices la app.</p>
</div>

<div class=\"section\">
  <h2>Uso de la App</h2>
  <ul>
    <li>Eres responsable del contenido que agregas (documentos, reservas, gastos).</li>
    <li>No subas contenido que no tengas derecho a almacenar en tu dispositivo.</li>
    <li>Voythrix se ofrece para la planificación y organización personal de viajes.</li>
  </ul>
</div>

<div class=\"section\">
  <h2>Copias de seguridad y seguridad</h2>
  <p>Puedes exportar copias de seguridad cifradas con una contraseña. Mantén la contraseña segura; no podemos recuperar copias cifradas sin ella.</p>
</div>

<div class=\"section\">
  <h2>Privacidad</h2>
  <p>Consulta nuestra Política de Privacidad para saber cómo se manejan tus datos localmente en tu dispositivo.</p>
</div>

<div class=\"section\">
  <h2>Descargo de responsabilidad</h2>
  <p>Voythrix se proporciona “tal cual”, sin garantías de ningún tipo. No somos responsables por pérdidas de datos en tu dispositivo ni por problemas derivados de archivos dañados o mal formados.</p>
</div>

<div class=\"section\">
  <h2>Limitación de responsabilidad</h2>
  <p>En la máxima medida permitida por la ley, Voythrix no será responsable por daños indirectos, incidentales, especiales, consecuentes o punitivos, ni por pérdidas de datos, derivados del uso de la app.</p>
</div>

<div class=\"section\">
  <h2>Cambios en los Términos</h2>
  <p>Podemos actualizar estos Términos de vez en cuando. Seguir usando la app después de la entrada en vigor de los cambios constituye la aceptación de los Términos revisados.</p>
</div>

<div class=\"section\">
  <h2>Contacto</h2>
  <p>¿Preguntas sobre estos Términos? Escribe a <a href=\"mailto:voythrix@gmail.com\">voythrix@gmail.com</a>.</p>
</div>
''';

  String fr() => '''
<h1>Conditions d’Utilisation de Voythrix</h1>
<p><em>Dernière mise à jour : 2025-09-11</em></p>

<div class=\"section\">
  <h2>Accord</h2>
  <p>En utilisant Voythrix, vous acceptez ces Conditions. Si vous n’êtes pas d’accord, n’utilisez pas l’app.</p>
</div>

<div class=\"section\">
  <h2>Utilisation de l’App</h2>
  <ul>
    <li>Vous êtes responsable du contenu que vous ajoutez (documents, réservations, dépenses).</li>
    <li>N’ajoutez pas de contenu dont vous n’avez pas le droit de stocker sur votre appareil.</li>
    <li>Voythrix est fourni pour l’organisation et la planification personnelles de voyages.</li>
  </ul>
</div>

<div class=\"section\">
  <h2>Sauvegardes & sécurité</h2>
  <p>Vous pouvez exporter des sauvegardes chiffrées avec un mot de passe. Conservez‑le en sécurité ; nous ne pouvons pas récupérer les sauvegardes chiffrées sans celui‑ci.</p>
</div>

<div class=\"section\">
  <h2>Confidentialité</h2>
  <p>Consultez notre Politique de Confidentialité pour comprendre la gestion locale de vos données sur votre appareil.</p>
</div>

<div class=\"section\">
  <h2>Avertissement</h2>
  <p>Voythrix est fourni « en l’état » sans aucune garantie. Nous ne sommes pas responsables des pertes de données sur votre appareil ni des problèmes liés à des fichiers corrompus ou mal formés.</p>
</div>

<div class=\"section\">
  <h2>Limitation de responsabilité</h2>
  <p>Dans la limite autorisée par la loi, Voythrix ne peut être tenu responsable des dommages indirects, spéciaux, consécutifs ou punitifs, ni de toute perte de données, résultant de votre utilisation de l’app.</p>
</div>

<div class=\"section\">
  <h2>Modifications des Conditions</h2>
  <p>Nous pouvons mettre à jour ces Conditions périodiquement. L’utilisation continue de l’app après l’entrée en vigueur des changements vaut acceptation des Conditions révisées.</p>
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
