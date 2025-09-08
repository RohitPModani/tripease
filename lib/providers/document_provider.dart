import 'package:flutter/foundation.dart';
import '../models/document.dart';
import '../repositories/document_repository.dart';

class DocumentProvider extends ChangeNotifier {
  final DocumentRepository _repository;
  
  List<Document> _documents = [];
  List<Document> _personalDocuments = [];
  bool _isLoading = false;
  String? _error;

  DocumentProvider(this._repository);

  List<Document> get documents => _documents;
  List<Document> get personalDocuments => _personalDocuments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadDocuments(String tripId) async {
    _setLoading(true);
    try {
      _documents = await _repository.getDocumentsByTripId(tripId);
      _clearError();
    } catch (e) {
      _setError('Failed to load documents: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadPersonalDocuments() async {
    _setLoading(true);
    try {
      _personalDocuments = await _repository.getPersonalDocuments();
      _clearError();
    } catch (e) {
      _setError('Failed to load personal documents: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createDocument(Document document) async {
    try {
      await _repository.createDocument(document);
      
      if (document.isPersonal) {
        _personalDocuments.add(document);
      } else {
        _documents.add(document);
      }
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to create document: $e');
      rethrow;
    }
  }

  Future<void> updateDocument(Document document) async {
    try {
      await _repository.updateDocument(document);
      
      if (document.isPersonal) {
        final index = _personalDocuments.indexWhere((d) => d.id == document.id);
        if (index != -1) {
          _personalDocuments[index] = document;
        }
      } else {
        final index = _documents.indexWhere((d) => d.id == document.id);
        if (index != -1) {
          _documents[index] = document;
        }
      }
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to update document: $e');
      rethrow;
    }
  }

  Future<void> deleteDocument(String documentId) async {
    try {
      await _repository.deleteDocument(documentId);
      _documents.removeWhere((document) => document.id == documentId);
      _personalDocuments.removeWhere((document) => document.id == documentId);
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to delete document: $e');
      rethrow;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}