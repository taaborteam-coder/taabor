import React, { useState, useEffect } from 'react';
import { Outlet } from 'react-router-dom';
import Sidebar from '../components/Sidebar';
import Header from '../components/Header';
import { useTranslation } from 'react-i18next';

const DashboardLayout = () => {
    const [sidebarOpen, setSidebarOpen] = useState(true);
    const { i18n } = useTranslation();

    // Auto-collapse sidebar on specific conditions if needed, keeping simple for now

    // Ensure direction is correct on mount
    useEffect(() => {
        const dir = i18n.dir();
        document.documentElement.dir = dir;
        document.documentElement.lang = i18n.language;
    }, [i18n.language, i18n]);

    return (
        <div className="flex h-screen bg-gray-50 font-sans overflow-hidden">
            {/* Sidebar */}
            <Sidebar isOpen={sidebarOpen} />

            {/* Main Wrapper */}
            <div className="flex-1 flex flex-col min-w-0 overflow-hidden">
                <Header
                    toggleSidebar={() => setSidebarOpen(!sidebarOpen)}
                    sidebarOpen={sidebarOpen}
                />

                {/* Page Content */}
                <main className="flex-1 overflow-auto p-4 md:p-6 lg:p-8 scroll-smooth">
                    <div className="max-w-7xl mx-auto animate-in fade-in duration-500">
                        <Outlet />
                    </div>
                </main>
            </div>
        </div>
    );
};

export default DashboardLayout;
