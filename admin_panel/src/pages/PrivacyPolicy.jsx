import React from 'react';
import Navbar from '../landing/Navbar';
import Footer from '../landing/Footer';

export default function PrivacyPolicy() {
    return (
        <div className="min-h-screen bg-gray-50 font-sans">
            <Navbar />

            <main className="pt-32 pb-20 max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="bg-white rounded-3xl p-8 md:p-12 shadow-sm border border-gray-100">
                    <h1 className="text-4xl font-extrabold text-slate-900 mb-8">Privacy Policy</h1>
                    <p className="text-slate-500 mb-8">Last updated: December 15, 2025</p>

                    <div className="prose prose-indigo max-w-none text-slate-600">
                        <h3>1. Introduction</h3>
                        <p>Welcome to Taabor. We respect your privacy and are committed to protecting your personal data. This privacy policy will inform you as to how we look after your personal data when you visit our website or mobile application.</p>

                        <h3>2. Data We Collect</h3>
                        <p>We may collect, use, store and transfer different kinds of personal data about you which we have grouped together follows: Identity Data, Contact Data, Technical Data, and Usage Data.</p>

                        <h3>3. How We Use Your Data</h3>
                        <p>We will only use your personal data when the law allows us to. Most commonly, we will use your personal data in the following circumstances:</p>
                        <ul>
                            <li>Where we need to perform the contract we are about to enter into or have entered into with you.</li>
                            <li>Where it is necessary for our legitimate interests (or those of a third party) and your interests and fundamental rights do not override those interests.</li>
                            <li>Where we need to comply with a legal or regulatory obligation.</li>
                        </ul>

                        <h3>4. Data Security</h3>
                        <p>We have put in place appropriate security measures to prevent your personal data from being accidentally lost, used or accessed in an unauthorized way, altered or disclosed.</p>

                        <h3>5. Contact Us</h3>
                        <p>If you have any questions about this privacy policy or our privacy practices, please contact us at: support@taabor.com</p>
                    </div>
                </div>
            </main>

            <Footer />
        </div>
    );
}
