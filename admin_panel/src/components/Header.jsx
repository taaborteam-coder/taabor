import React, { useState } from 'react';
import { Menu, Bell, Search, Globe, ChevronDown } from 'lucide-react';
import { useTranslation } from 'react-i18next';

const Header = ({ toggleSidebar, sidebarOpen }) => {
    const { t, i18n } = useTranslation();
    const [isLangMenuOpen, setIsLangMenuOpen] = useState(false);

    const languages = [
        { code: 'ar', name: 'العربية', dir: 'rtl' },
        { code: 'en', name: 'English', dir: 'ltr' },
        { code: 'ku', name: 'کوردی', dir: 'rtl' }
    ];

    const currentLang = languages.find(l => l.code === i18n.language) || languages[0];

    const changeLanguage = (langCode) => {
        i18n.changeLanguage(langCode);
        const lang = languages.find(l => l.code === langCode);
        document.documentElement.dir = lang.dir;
        document.documentElement.lang = lang.code;
        setIsLangMenuOpen(false);
    };

    return (
        <header className="bg-white/80 backdrop-blur-md shadow-sm border-b border-gray-100 h-16 px-4 flex items-center justify-between sticky top-0 z-10 transition-all duration-300">

            {/* Left Side: Toggle & Search */}
            <div className="flex items-center gap-4 flex-1">
                <button
                    onClick={toggleSidebar}
                    className="p-2 hover:bg-gray-100 rounded-lg text-gray-600 transition-colors"
                >
                    <Menu size={20} />
                </button>

                <div className="relative hidden md:block max-w-md w-full">
                    <Search className={`absolute ${i18n.dir() === 'rtl' ? 'right-3' : 'left-3'} top-1/2 transform -translate-y-1/2 text-gray-400`} size={18} />
                    <input
                        type="text"
                        placeholder={t('search')}
                        className={`w-full ${i18n.dir() === 'rtl' ? 'pr-10 pl-4' : 'pl-10 pr-4'} py-2 bg-gray-50 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500/20 focus:border-indigo-500 transition-all`}
                    />
                </div>
            </div>

            {/* Right Side: Actions & Profile */}
            <div className="flex items-center gap-2 md:gap-4">

                {/* Language Switcher */}
                <div className="relative">
                    <button
                        onClick={() => setIsLangMenuOpen(!isLangMenuOpen)}
                        className="flex items-center gap-2 p-2 hover:bg-gray-100 rounded-lg text-gray-600 transition-colors"
                    >
                        <Globe size={18} />
                        <span className="text-sm font-medium hidden sm:block">{currentLang.name}</span>
                        <ChevronDown size={14} className="opacity-50" />
                    </button>

                    {isLangMenuOpen && (
                        <div className={`absolute top-full mt-2 ${i18n.dir() === 'rtl' ? 'left-0' : 'right-0'} w-40 bg-white rounded-xl shadow-xl border border-gray-100 py-1 overflow-hidden z-50 animate-in fade-in slide-in-from-top-2`}>
                            {languages.map((lang) => (
                                <button
                                    key={lang.code}
                                    onClick={() => changeLanguage(lang.code)}
                                    className={`w-full text-left px-4 py-2 text-sm hover:bg-indigo-50 hover:text-indigo-600 flex items-center justify-between
                                        ${currentLang.code === lang.code ? 'bg-indigo-50 text-indigo-700 font-medium' : 'text-gray-700'}
                                    `}
                                >
                                    <span>{lang.name}</span>
                                    {currentLang.code === lang.code && <div className="w-1.5 h-1.5 rounded-full bg-indigo-600"></div>}
                                </button>
                            ))}
                        </div>
                    )}
                </div>

                {/* Notifications */}
                <button className="p-2 relative hover:bg-gray-100 rounded-lg text-gray-600 transition-colors">
                    <Bell size={20} />
                    <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-rose-500 rounded-full ring-2 ring-white"></span>
                </button>

            </div>
        </header>
    );
};

export default Header;
