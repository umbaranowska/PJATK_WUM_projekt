import os
import h5py
import numpy as np
import matplotlib.pyplot as plt
# %matplotlib inline

def read_image(folder, filename):
    '''reads patient id, image and label into a dictinary for a single .mat file'''
    image_dict = {}
    f = h5py.File(f'{folder}/{filename}','r')
    image_dict['PID'] = np.array(f.get('cjdata/PID')).transpose()
    image_dict['image'] = np.array(f.get('cjdata/image'))
    image_dict['label'] = np.array(f.get('cjdata/label'))
    image_dict['mask'] = np.array(f.get('cjdata/tumorMask'))
    return image_dict

def read_images_to_array(folder):
    '''reads data for all images in a given folder and turns it into numpy arrays'''
    filenames = os.listdir(folder)
    images_pid = []
    images_image = []
    images_label = []
    images_mask = []
    for filename in filenames:
        try:
            image_dict = read_image(folder, filename)
            assert image_dict['image'].shape == (512, 512)
            images_pid.append(''.join(image_dict['PID'].astype(str).tolist()[0])) # converts pid from array to single string
            images_image.append(image_dict['image'])
            images_label.append(image_dict['label'].astype(int)[0][0] - 1) # extracts label from array to single integer AND substracts 1 so labels are 0-2 now
            images_mask.append(image_dict['mask'])
        except:
            print(filename)
    images_pid = np.array(images_pid)
    images_image = np.array(images_image)
    images_label = np.array(images_label)
    images_mask = np.array(images_mask)
    return images_pid, images_image, images_label, images_mask

def convert_labels_to_strings(images_label):
    label_dict = {
        0 : 'meningioma',
        1 : 'glioma',
        2 : 'pituitary tumor'
    }
    images_label_string = np.array([label_dict[i] for i in images_label])
    return images_label_string

def plot_image(id, images_pid, images_image, images_label_string, images_mask):
    plt.imshow(images_image[id], cmap = 'gray')
    plt.imshow(images_mask[id], cmap = 'Reds', alpha = 0.3)
    plt.title(f'image {id}, patient ID: {images_pid[id]}, tumor type: {images_label_string[id]}')
    plt.show()