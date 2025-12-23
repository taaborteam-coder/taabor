import React, { Suspense } from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import DashboardLayout from './layouts/DashboardLayout';
import Dashboard from './pages/Dashboard';
import BusinessPage from './pages/BusinessPage';
import UsersPage from './pages/UsersPage';
import AnalyticsPage from './pages/AnalyticsPage';
import QueuePage from './pages/QueuePage';
import QueuePage from './pages/QueuePage';
import SettingsPage from './pages/SettingsPage';
import NotificationPage from './pages/NotificationPage';
import ReviewsPage from './pages/ReviewsPage';
import LandingPage from './landing/LandingPage';
import PrivacyPolicy from './pages/PrivacyPolicy';
import TermsOfService from './pages/TermsOfService';

// Simple loading spinner
const Loading = () => (
    <div className="flex h-screen items-center justify-center bg-gray-50">
        <div className="w-12 h-12 border-4 border-indigo-200 border-t-indigo-600 rounded-full animate-spin"></div>
    </div>
);

import { AuthProvider } from './context/AuthContext';
import { ToastProvider } from './context/ToastContext';
import ProtectedRoute from './components/ProtectedRoute';

import LoginPage from './pages/LoginPage';
import RegisterAdminPage from './pages/RegisterAdminPage';

function App() {
    return (
        <ToastProvider>
            <AuthProvider>
                <BrowserRouter>
                    <Suspense fallback={<Loading />}>
                        <Routes>

                            <Route path="/" element={<LandingPage />} />
                            <Route path="/privacy-policy" element={<PrivacyPolicy />} />
                            <Route path="/terms-of-service" element={<TermsOfService />} />
                            <Route path="/login" element={<LoginPage />} />
                            <Route path="/register-admin" element={<RegisterAdminPage />} />

                            <Route path="/dashboard" element={
                                <ProtectedRoute requireAdmin={true}>
                                    <DashboardLayout />
                                </ProtectedRoute>
                            }>
                                <Route index element={<Dashboard />} />
                                <Route path="businesses" element={<BusinessPage />} />
                                <Route path="users" element={<UsersPage />} />
                                <Route path="queues" element={<QueuePage />} />
                                <Route path="analytics" element={<AnalyticsPage />} />
                                <Route path="notifications" element={<NotificationPage />} />
                                <Route path="reviews" element={<ReviewsPage />} />
                                <Route path="settings" element={<SettingsPage />} />
                            </Route>

                            {/* Redirect unknown routes to Landing */}
                            <Route path="*" element={<Navigate to="/" replace />} />
                        </Routes>
                    </Suspense>
                </BrowserRouter>
            </AuthProvider>
        </ToastProvider>
    );
}

export default App;
