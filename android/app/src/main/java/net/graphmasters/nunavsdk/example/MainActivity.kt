package net.graphmasters.nunavsdk.example

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.ui.Modifier
import androidx.core.content.ContextCompat
import net.graphmasters.nunavsdk.NunavSdk
import net.graphmasters.nunavsdk.example.ui.theme.NUNAVSdkExampleTheme

class MainActivity: ComponentActivity() {

    private val requestPermissionLauncher =
        registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) {
            if (this.allNeededPermissionsGranted()) {
                startNavigation(this)
            } else {
                Toast.makeText(
                    this,
                    "Location and post notifications permissions required for navigation",
                    Toast.LENGTH_SHORT
                ).show()
            }
        }

    private val neededPermissions = arrayOf(
        Manifest.permission.ACCESS_COARSE_LOCATION,
        Manifest.permission.ACCESS_FINE_LOCATION,
        *if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            arrayOf(Manifest.permission.POST_NOTIFICATIONS)
        } else {
            emptyArray()
        }
    )

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        setContent {
            NUNAVSdkExampleTheme() {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    Button(
                        modifier = Modifier.wrapContentSize(),
                        onClick = { this.startNavigation(this) }
                    ) {
                        Text(text = "Start Navigation")
                    }
                }
            }
        }

        // Initialize the NUNAV SDK with your api key.
        NunavSdk.initialize(this, "Your API-key")
    }

    @SuppressLint("MissingPermission")
    private fun startNavigation(context: Context) {
        if (allNeededPermissionsGranted()) {
            try {
                // Start navigation to the desired destination.
                // A new activity will be started containing the complete navigation workflow.
                // Make sure to check for the required permissions before calling this method!
                NunavSdk.startNavigation(
                    context = this,
                    latitude = 52.376169,
                    longitude = 9.741784
                )
            } catch (e: Exception) {
                Toast.makeText(context, e.toString(), Toast.LENGTH_LONG).show()
            }
        } else {
            this.requestPermissionLauncher.launch(neededPermissions)
        }
    }

    private fun allNeededPermissionsGranted(): Boolean =
        neededPermissions.all { permission ->
            ContextCompat.checkSelfPermission(this, permission) == PackageManager.PERMISSION_GRANTED
        }
}