import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class StepperTest extends StatefulWidget {
  const StepperTest({super.key});

  @override
  State<StepperTest> createState() => _StepperTestState();
}

class _StepperTestState extends State<StepperTest> {

   int activeStep = 0;
  @override
  Widget build(BuildContext context) {
    return  EasyStepper(
      direction: Axis.vertical,
        activeStep: activeStep,
        // lineLength: 70,
        // lineSpace: 0,
        // lineType: LineType.normal,
        // defaultLineColor: Colors.white,
        // finishedLineColor: Colors.orange,
        activeStepTextColor: Colors.black87,
        finishedStepTextColor: Colors.black87,
        // internalPadding: 10,
        showLoadingAnimation: false,
        lineStyle:const LineStyle(lineType:LineType.normal),
        stepRadius: 8,
        showStepBorder: true,
        // lineDotRadius: 1.5,
        steps: [
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 0 ? Colors.orange : Colors.white,
              ),
            ),
            title: 'Waiting',
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 1 ? Colors.orange : Colors.white,
              ),
            ),
            title: 'Order Received',
            topTitle: true,
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 2 ? Colors.orange : Colors.white,
              ),
            ),
            title: 'Preparing',
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 3 ? Colors.orange : Colors.white,
              ),
            ),
            title: 'On Way',
            topTitle: true,
          ),
          EasyStep(
            customStep: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 7,
                backgroundColor:
                    activeStep >= 4 ? Colors.orange : Colors.white,
              ),
            ),
            title: 'Delivered',
          ),
        ],
        onStepReached: (index) =>
            setState(() => activeStep = index),
    );
  }
}
