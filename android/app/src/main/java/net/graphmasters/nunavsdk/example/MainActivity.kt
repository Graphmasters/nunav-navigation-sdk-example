package net.graphmasters.nunavsdk.example

import android.annotation.SuppressLint
import android.content.Context
import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import net.graphmasters.androidlibrary.Destination
import net.graphmasters.androidlibrary.NunavSdk
import net.graphmasters.nunavsdk.example.ui.theme.NUNAVSdkExampleTheme

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            NUNAVSdkExampleTheme {
                // A surface container using the 'background' color from the theme
                Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background) {
                    Button(
                        modifier = Modifier.wrapContentSize(),
                        onClick = { startNavigation(this@MainActivity) }
                    ) {
                        Text(text = "Start Navigation")
                    }
                }
            }
        }

        NunavSdk.init(this, "YOUR_API_KEY")
    }
}

@SuppressLint("MissingPermission")
internal fun startNavigation(context: Context) {
    try {
        NunavSdk.startNavigation(
            context = context,
            destination = Destination.Builder()
                .latitude(52.3780505280251)
                .longitude(9.743045788541911)
                .label("Hauptbahnhof")
                .build()
        )
    } catch (e: Exception) {
        e.printStackTrace()
        Toast.makeText(context, e.toString(), Toast.LENGTH_LONG).show()
    }
}