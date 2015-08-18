package mx.com.scitum.helpers

import java.text.Normalizer

/**
 * Created by daniel.jimenez on 17/08/2015.
 */
class CleaningStuff {

    static String makeSafeURL(String string) {
        string = Normalizer.normalize(string, Normalizer.Form.NFD).replaceAll("\\p{IsM}+", "")
        return string?.replaceAll(/\s+/, '_')?.replaceAll(/\//, '-')?.toLowerCase()
    }
}
