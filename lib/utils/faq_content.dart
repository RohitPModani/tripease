import 'package:flutter/material.dart';

/// Returns the FAQ HTML content to render inside HtmlContentModal.
/// Keeping this as HTML lets us use the existing flutter_html renderer
/// and style sections consistently.
String buildFaqHtml(BuildContext context) {
  return '''
<h1>Voythrix FAQ</h1>

<div class="section">
  <h2>Getting Started</h2>
  <p><strong>What is Voythrix?</strong><br/>
  A privacy‑first, offline trip planner to manage trips, tasks, bookings, expenses and travel documents in one place.</p>
  <p><strong>How do I create a trip?</strong><br/>
  Go to the Trips tab → “Create Trip”, add destinations, pick start/end dates, choose a default currency, then save.</p>
  <p><strong>Does it work offline?</strong><br/>
  Yes. All data is stored locally on your device (no cloud sync).</p>
</div>

<div class="section">
  <h2>Trips</h2>
  <p><strong>How are trips organized?</strong><br/>
  Filter by Active, Upcoming, or Completed and search by name/destination.</p>
  <p><strong>What happens when I delete a trip?</strong><br/>
  The trip and its related todos, bookings, expenses, and trip documents are removed from the app’s database.</p>
  <p><strong>Can I edit a trip?</strong><br/>
  Yes — open the trip and use the menu to edit.</p>
</div>

<div class="section">
  <h2>Itinerary</h2>
  <p><strong>Can I plan daily activities?</strong><br/>
  Yes. Add per‑day activities with time, type, and location.</p>
  <div class="highlight">
    Note: In this version, itinerary items are not exported/imported.
  </div>
</div>

<div class="section">
  <h2>To‑Dos</h2>
  <p><strong>What can I track?</strong><br/>
  Title, description, priority, due date; search and filter by priority; swipe to edit/delete.</p>
  <p><strong>Do completed items affect stats?</strong><br/>
  Yes. Overview shows completed/total progress.</p>
</div>

<div class="section">
  <h2>Bookings</h2>
  <p><strong>What types are supported?</strong><br/>
  Flight, hotel, activity, transport, restaurant, and other — with status (confirmed/pending/cancelled).</p>
  <p><strong>Can I attach files?</strong><br/>
  Yes. Add images/PDF/docs (max 5MB each). Attachments are stored in the app’s documents area.</p>
  <p><strong>Is there a limit?</strong><br/>
  Up to 15 bookings per trip.</p>
  <p><strong>How do I view/share/save attachments?</strong><br/>
  Tap an attachment to preview, share, or save to Photos/Files (depending on file type).</p>
</div>

<div class="section">
  <h2>Expenses</h2>
  <p><strong>What can I track?</strong><br/>
  Title, amount, category, date, paid by, and description. Totals and category breakdown are shown.</p>
  <p><strong>Do you support splitting?</strong><br/>
  The data model supports splits, but the UI for entering splits is not exposed yet.</p>
</div>

<div class="section">
  <h2>Documents</h2>
  <p><strong>What documents can I store?</strong><br/>
  Personal documents like passport, visa, insurance, and other files. Search and filter are supported.</p>
  <p><strong>Which file types work?</strong><br/>
  Images (JPG/PNG/etc.), PDFs, and common docs (DOC/DOCX/TXT).</p>
  <p><strong>Is there a limit?</strong><br/>
  Up to 10 personal documents total.</p>
</div>

<div class="section">
  <h2>Backups & Restore</h2>
  <p><strong>How do I back up my data?</strong><br/>
  Settings → Export Data. Choose a folder, optionally set a password, and save a <code>.voy</code> backup.</p>
  <p><strong>Is the backup encrypted?</strong><br/>
  Yes if you set a password (AES‑256 with IV + checksum). Keep your password safe — it cannot be recovered.</p>
  <p><strong>How do I restore?</strong><br/>
  Settings → Import Data → select a <code>.voy</code> file; enter the password if required.</p>
</div>

<div class="section">
  <h2>Data & Privacy</h2>
  <p><strong>Where is my data stored?</strong><br/>
  Locally in the app’s database and attachment folders. There is no cloud sync.</p>
  <p><strong>What is included in backups?</strong><br/>
  Trips, todos, bookings (+attachments), expenses, documents, and app settings; plus integrity metadata.</p>
</div>

<div class="section">
  <h2>Troubleshooting</h2>
  <ul>
    <li><strong>Import: invalid/corrupted file</strong> — Use a valid Voythrix <code>.voy</code> backup and try again.</li>
    <li><strong>Import: password required</strong> — Enter the correct backup password.</li>
    <li><strong>Attachment says “File not found”</strong> — The original file was moved/deleted; re‑attach it.</li>
    <li><strong>Attachment too large</strong> — Booking attachments must be ≤ 5MB.</li>
  </ul>
</div>

<div class="contact-info">
  Need more help? Tap “Contact Support” below to email us.
  <br/>Email: <a href="mailto:voythrix@gmail.com">voythrix@gmail.com</a>
  <br/>Subject: Voythrix Support
  </div>
''';
}

