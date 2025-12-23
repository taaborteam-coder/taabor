import { storage } from '../firebase';
import { ref, uploadBytes, getDownloadURL } from 'firebase/storage';
import { v4 as uuidv4 } from 'uuid';

export const uploadService = {
    /**
     * Upload a file to Firebase Storage
     * @param {File} file - The file to upload
     * @param {string} path - The storage path (folder)
     * @returns {Promise<string>} - The download URL
     */
    uploadFile: async (file, path = 'images') => {
        if (!file) return null;

        const fileExtension = file.name.split('.').pop();
        const fileName = `${uuidv4()}.${fileExtension}`;
        const storageRef = ref(storage, `${path}/${fileName}`);

        try {
            const snapshot = await uploadBytes(storageRef, file);
            const downloadURL = await getDownloadURL(snapshot.ref);
            return downloadURL;
        } catch (error) {
            console.error("Error uploading file:", error);
            throw error;
        }
    }
};
