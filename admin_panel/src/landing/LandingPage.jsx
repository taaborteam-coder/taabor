import React from 'react';
import Navbar from './Navbar';
import Hero from './Hero';
import Features from './Features';
import FAQ from './FAQ';
import Contact from './Contact';
import Footer from './Footer';

export default function LandingPage() {
    return (
        <div className="min-h-screen bg-white font-sans antialiased selection:bg-indigo-100 selection:text-indigo-700">
            <Navbar />
            <Hero />
            <Features />
            <FAQ />
            <Contact />
            <Footer />
        </div>
    );
}
