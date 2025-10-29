import boto3
from botocore.exceptions import ClientError

client = boto3.client('ec2')

# List Active EC2 instances
activeInstancesInfo = client.describe_instances(
    Filters=[
        {
            'Name': 'instance-state-name',
            'Values': [
                'running',
            ]
        },
    ]
)

# List ebs snapshots
snapshot_response = client.describe_snapshots(OwnerIds=['self'])

# print("Snapshots are ", snapshots)

for snap_shot in snapshot_response['Snapshots']:
    snapshot_id = snap_shot['SnapshotId']
    volume_id = snap_shot['VolumeId']
    print("snapshot_id ", snapshot_id)
    print("volume_id ", volume_id)

    if not volume_id:
        client.delete_snapshot(SnapshotId=snapshot_id)
        print("Deleting snapshot as it is not associated with any volume")
    else:
        # Delete snapshot if volume doesn't exist
        try:
            volume_response = client.describe_volumes(VolumeIds=[volume_id])
            print("volume response is ", volume_response)
            print("Attached volume is  ", volume_response['Volumes'][0]['Attachments'])
            if not volume_response['Volumes'][0]['Attachments']:
                client.delete_snapshot(
                    SnapshotId=snapshot_id
                )
                print(f"Deleted snapshot {snapshot_id} as it's not attached to any volume")
        except ClientError as e:   
            print("e response is ", e.response['Error']['Code'])
            if e.response['Error']['Code'] == 'InvalidVolume.NotFound':
                client.delete_snapshot(
                    SnapshotId=snapshot_id
                )
                print(f"Deleted snapshot {snapshot_id} as it's attached volume is deleted")