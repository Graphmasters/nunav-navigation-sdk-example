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
import androidx.compose.ui.Modifier
import net.graphmasters.nunavsdk.Destination
import net.graphmasters.nunavsdk.NunavSdk
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

        // Initialize the SDK with your API key. This should be done before calling NunavSdk.startNavigation().
        NunavSdk.init(this, "YOUR_API_KEY")
    }
}

@SuppressLint("MissingPermission")
internal fun startNavigation(context: Context) {
    try {
        // Start navigation to the desired destination.
        // A new activity will be started containing the complete navigation workflow.
        // Make sure to check for the required permissions before calling this method!!!
        NunavSdk.startNavigation(
            context = context,
            destination = Destination.Builder()
                .location(52.3780505280251, 9.743045788541911)
                .label("My destination")
                .build()
        )
    } catch (e: Exception) {
        e.printStackTrace()
        Toast.makeText(context, e.toString(), Toast.LENGTH_LONG).show()
    }
}